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

## Running

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

## Files

- `setup.sql` — database schema
- `setupData.sql` — seed data
- `db_bot.py` — main app
- `config.json` — your OpenAI API key (not committed)
