import json
from openai import OpenAI
import os
import sqlite3
from time import sleep

print("Running db_bot.py!")

fdir = os.path.dirname(__file__)
def getPath(fname):
    return os.path.join(fdir, fname)

# SQLITE
sqliteDbPath = getPath("aidb.sqlite")
setupSqlPath = getPath("setup.sql")
setupSqlDataPath = getPath("setupData.sql")

# Erase previous db and create fresh one
if os.path.exists(sqliteDbPath):
    os.remove(sqliteDbPath)

sqliteCon = sqlite3.connect(sqliteDbPath)
sqliteCursor = sqliteCon.cursor()

with (
    open(setupSqlPath) as setupSqlFile,
    open(setupSqlDataPath) as setupSqlDataFile
):
    setupSqlScript = setupSqlFile.read()
    setupSqlDataScript = setupSqlDataFile.read()

sqliteCursor.executescript(setupSqlScript)
sqliteCursor.executescript(setupSqlDataScript)

def runSql(query):
    result = sqliteCursor.execute(query).fetchall()
    return result

# OPENAI
configPath = getPath("config.json")
with open(configPath) as configFile:
    config = json.load(configFile)

openAiClient = OpenAI(api_key=config["openaiKey"])
openAiClient.models.list()
chosen_model = "gpt-4o"

def getChatGptResponse(content):
    stream = openAiClient.chat.completions.create(
        model=chosen_model,
        messages=[{"role": "user", "content": content}],
        stream=True,
    )
    responseList = []
    for chunk in stream:
        if chunk.choices[0].delta.content is not None:
            responseList.append(chunk.choices[0].delta.content)
    return "".join(responseList)


# strategies
commonSqlOnlyRequest = " Give me a sqlite select statement that answers the question. Only respond with sqlite syntax. Do not use parameterized queries or placeholders — all values must be written inline. If there is an error do not explain it!"

strategies = {
    "zero_shot": setupSqlScript + commonSqlOnlyRequest,

    "single_domain_double_shot": (
        setupSqlScript +
        " What ingredients are in the Chicken Pesto recipe? " +
        "\nSELECT i.name\nFROM Ingredient i\nJOIN Recipe_ingredient ri ON i.ingredient_id = ri.ingredient_id\nJOIN Recipe r ON ri.recipe_id = r.recipe_id\nWHERE r.name = 'Chicken Pesto (4 Meals)';\n" +
        commonSqlOnlyRequest
    )
}

questions = [
    "What ingredients do I still need to buy this week (not covered by inventory)?",
    "Which recipes are planned for this week and what are their calories per serving?",
    "What is the total estimated cost of groceries I need to buy?",
    "Which inventory items expire soonest?",
    "Which recipe this week has the most protein per serving?",
    "What is the total protein across all dinners planned this week?",
]


def sanitizeForJustSql(value):
    gptStartSqlMarker = "```"
    gptEndSqlMarker = "```"
    if gptStartSqlMarker in value:
        value = value.split(gptStartSqlMarker, 1)[1]
        newline_index = value.find("\n")
        if newline_index != -1:
            value = value[newline_index + 1:]
    if gptEndSqlMarker in value:
        value = value.split(gptEndSqlMarker, 1)[0]
    return value.strip()


print("\nMeal Prep Assistant ready! Type 'quit' to exit.\n")

while True:
    question = input("Ask a question about your meal plan: ").strip()

    if question.lower() == "quit":
        break

    if not question:
        continue

    try:
        getSqlPrompt = strategies["single_domain_double_shot"] + " " + question
        sqlSyntaxResponse = getChatGptResponse(getSqlPrompt)
        sqlSyntaxResponse = sanitizeForJustSql(sqlSyntaxResponse)

        queryRawResponse = str(runSql(sqlSyntaxResponse))

        friendlyPrompt = (
            "I asked the question \"" + question + "\" against my meal prep database "
            "and the raw result was \"" + queryRawResponse + "\". "
            "Ingredient costs are stored in cents (divide by 100 for dollars). "
            "Macros (calories, protein, carbs, fat) in the Recipe table are totals for all servings — divide by the servings count for per-serving values. "
            "Please give a concise, friendly response. Do not add extra suggestions or chatter."
        )
        friendlyResponse = getChatGptResponse(friendlyPrompt)
        print(f"\n{friendlyResponse}\n")
    except Exception as err:
        print(f"Error: {err}\n")

    sleep(3)  # avoid hitting rate limits between requests

sqliteCursor.close()
sqliteCon.close()
print("Goodbye!")
