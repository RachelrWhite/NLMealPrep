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
## Example Queries and Responses

## Example Queries and Responses
## Example Queries and Responses

| # | Question | SQL Query | Response |
|---|---|---|---|
| **1** | Which recipes are planned for this week and what are their calories per serving? | `SELECT r.name, r.calories / r.servings AS calories_per_serving FROM Planned_meal pm JOIN Planned_meal_recipe pmr ON pm.planned_meal_id = pmr.planned_meal_id JOIN Recipe r ON pmr.recipe_id = r.recipe_id WHERE pm.date BETWEEN date('now','start of week') AND date('now','start of week','+6 days');` | No recipes are currently planned for this week. |
| **2** | What is the total estimated cost of groceries I need to buy? | `SELECT SUM(i.cost * gli.quantity_needed) AS total_estimated_cost FROM Grocery_list_item gli JOIN Ingredient i ON gli.ingredient_id = i.ingredient_id WHERE gli.covered_by_inventory = FALSE;` | Total estimated grocery cost: **$17.84** |
| **3** | Which inventory items expire soonest? | `SELECT ingredient_id, expiration_date FROM Inventory ORDER BY expiration_date ASC LIMIT 1;` | The item that expires soonest is **item 26**, expiring on **March 2, 2026**. |
| **4** | Which recipe this week has the most protein per serving? | `SELECT r.name FROM Recipe r JOIN Planned_meal_recipe pmr ON r.recipe_id = pmr.recipe_id JOIN Planned_meal pm ON pmr.planned_meal_id = pm.planned_meal_id WHERE pm.date BETWEEN date('now','weekday 0','-7 days') AND date('now','weekday 0','-1 day') ORDER BY (r.protein / r.servings) DESC LIMIT 1;` | Highest protein recipe: **Chicken Pesto (4 Meals)** |
| **5** | What is the total protein across all dinners planned this week? | `SELECT SUM(r.protein) FROM Planned_meal pm JOIN Planned_meal_recipe pmr ON pm.planned_meal_id = pmr.planned_meal_id JOIN Recipe r ON pmr.recipe_id = r.recipe_id WHERE pm.meal_type = 'dinner' AND pm.date BETWEEN DATE('now','weekday 0','-6 days') AND DATE('now','weekday 0');` | Total protein across planned dinners this week: **82 grams** |
| **6** | What ingredients do I still need to buy this week? | `SELECT i.name, gli.quantity_needed FROM Grocery_list_item gli JOIN Ingredient i ON gli.ingredient_id = i.ingredient_id WHERE gli.covered_by_inventory = 0;` | Chicken Breast (3), Rotini Pasta (2), Mozzarella (3), Pesto (2), Basmati Rice (3), Fajita Seasoning (1), Onion (1), Bell Pepper (1), Mexican Cheese (1), Curry Mix (1), Potatoes (1), Carrot (1), Butter (1), Green Onions (1), Mushrooms (1), Sour Cream (1), White Wine (1), Elbow Macaroni (1), Cheddar (1), Soy Sauce (1), Orange Juice (1), Garlic (1), Ginger (1) |
## Things it had a difficult time with: 
* if the wording of the question was a little off or if you used the word 'recipe' instead of meal it really threw it off

## Prompting strategies: 
* zero shot and Single domain/double shot. For this, I noticed that the double-shot strategy produced more accurate SQL. This is probably because the example gave GPT a hint about which schema's table and columns relate to natural language. 

## Files

- `setup.sql` — database schema
- `setupData.sql` — seed data
- `db_bot.py` — main app
- `config.json` — your OpenAI API key (not committed)
