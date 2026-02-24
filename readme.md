# NL Meal Prep Assistant

A natural language meal prep assistant that uses GPT-4o and SQLite to answer questions about your weekly meal plan, recipes, ingredients, grocery list, and inventory.

## How it works

1. Your meal prep data (recipes, ingredients, planned meals, inventory) is loaded into a local SQLite database
2. You type a plain English question
3. GPT-4o receives your database schema and generates a SQLite query
4. The query runs against your database
5. The raw result is sent back to GPT-4o to produce a friendly, readable answer

## Setup

1. Clone the repo
2. Create a virtual environment and install dependencies:
    ```bash
    python3 -m venv venv
    source venv/bin/activate
    pip install openai
    ```
3. Create a `config.json` file in the project folder (this is gitignored — do not commit it):
    ```json
    {
        "openaiKey": "your-openai-api-key-here"
    }
    ```

## Running && Example of a query

```bash
source venv/bin/activate
python db_bot.py
```

Then just type your questions:
```
Ask a question about your meal plan: Which recipe has the most protein?
The recipe with the most protein per serving this week is Chicken Pesto!

Ask a question about your meal plan: quit
Goodbye!
```
## More examples of questions this database can answer: 
  1. "What ingredients do I still need to buy this week (not covered by inventory)?"  
  2. "Which recipes are planned for this week and what are their calories per         
  serving?"                                                                           
  3. "What is the total estimated cost of groceries I need to buy?"                   
  4. "Which inventory items expire soonest?"
  5. "Which recipe this week has the most protein per serving?"
  6. "What is the total protein across all dinners planned this week?"
## Things it had a difficult time with: 
* if the wording of the question was a little off or if you used the word 'recipe' instead of meal it really threw it off

## Prompting strategies: 
* zero shot and Single domain/double shot. For this, I noticed that the double-shot strategy produced more accurate SQL. This is probably because the example gave GPT a hint about which schema's table and columns relate to natural language. 

## Files

- `setup.sql` — database schema
- `setupData.sql` — seed data
- `db_bot.py` — main app
- `config.json` — your OpenAI API key (not committed)
