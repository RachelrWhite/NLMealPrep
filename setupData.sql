-- Auto-generated seed data from '0001 - Meal Plan Macro Spreadsheet.xlsx'
-- Costs stored in cents (bigint) for Ingredient.cost.

insert into User (user_id, name, email) values
(1, 'Rachel White', 'rachel.white@example.com');

insert into Ingredient (ingredient_id, name, cost) values
(1, 'Great Value Rotini Pasta', 24),
(2, 'Great Value Basmati Rice (5ib bag)', 70),
(3, 'Tyson''s Boneless, Skinless Chicken Breast', 140),
(4, 'Onion', 17),
(5, 'Great Value Heavy Cream', 74),
(6, 'Great Value Whole Milk Mozzarella Cheese', 49),
(7, 'Classico Traditional Basil Pesto', 107),
(8, 'Seiete Chicken Fajita Seasoning', 113),
(9, 'Fresh Cravings Mild Salsa', 42),
(10, 'Bell Pepper', 62),
(11, 'Mexican Cheese', 25),
(12, 'Golden Curry Sauce Mix', 146),
(13, 'Potato (3ib bag)', 33),
(14, 'Carrot', 29),
(15, 'Beef Chuck Roast', 438),
(16, 'Great Value Wide Egg Noodles', 44),
(17, 'Salted Butter (16oz 4 stick pack)', 20),
(18, 'Green Onions', 25),
(19, 'Campbell''s Canned Condensed Beef Broth', 50),
(20, 'Canned Mushroom Pieces & Stems', 63),
(21, 'Daisy Sour Cream (squeeze pouch)', 14),
(22, 'Barefoot Pino Grigio White Wine ($10.87/1.5L)', 56),
(23, 'Great Value Elbow Macaroni', 24),
(24, 'Great Value Mild Cheddar Cheese', 49),
(25, 'Great Value Parmesean Cheese (Plastic Can)', 19),
(26, 'Milk', 10),
(27, 'Soy Sauce', 25),
(28, 'Brown Sugar', 10),
(29, 'Orange Juice', 30),
(30, 'Garlic', 8),
(31, 'Ginger', 6);

insert into Recipe (recipe_id, name, instructions, servings, calories, protein, carbs, fat, cook_time) values
(1, 'Chicken Pesto (4 Meals)', 'See meal plan spreadsheet for ingredients; cook ''Chicken Pesto (4 Meals)'' using standard method.', 4, 1490, 82, 99, 82, 30),
(2, 'Fajita Stir Fry (4 Meals)', 'See meal plan spreadsheet for ingredients; cook ''Fajita Stir Fry (4 Meals)'' using standard method.', 4, 949, 66, 123, 12, 30),
(3, 'Golden Curry (4 Meals)', 'See meal plan spreadsheet for ingredients; cook ''Golden Curry (4 Meals)'' using standard method.', 4, 1204, 67, 182, 16, 20),
(4, 'Beef Stroganoff (4 Meals)', 'See meal plan spreadsheet for ingredients; cook ''Beef Stroganoff (4 Meals)'' using standard method.', 4, 1385, 85, 82, 74, 20),
(5, 'Chicken Mac and Cheese (4 Meals)', 'See meal plan spreadsheet for ingredients; cook ''Chicken Mac and Cheese (4 Meals)'' using standard method.', 4, 1206, 97, 112, 28, 40),
(6, 'Terriyaki Chicken (4 Meals)', 'See meal plan spreadsheet for ingredients; cook ''Terriyaki Chicken (4 Meals)'' using standard method.', 4, 882, 62, 136, 4, 35);

insert into Recipe_ingredient (recipe_id, ingredient_id, quantity) values
(1, 3, 1.00),
(1, 1, 1.00),
(1, 5, 1.00),
(1, 6, 1.00),
(1, 7, 1.00),
(2, 3, 1.00),
(2, 2, 1.00),
(2, 8, 1.00),
(2, 4, 1.00),
(2, 9, 1.00),
(2, 10, 1.00),
(2, 11, 1.00),
(3, 3, 1.00),
(3, 2, 1.00),
(3, 12, 1.00),
(3, 13, 1.00),
(3, 14, 1.00),
(3, 4, 1.00),
(4, 15, 1.00),
(4, 16, 1.00),
(4, 17, 1.00),
(4, 18, 1.00),
(4, 19, 1.00),
(4, 20, 1.00),
(4, 21, 1.00),
(4, 22, 1.00),
(5, 3, 1.00),
(5, 23, 1.00),
(5, 6, 1.00),
(5, 24, 1.00),
(5, 25, 1.00),
(5, 4, 1.00),
(5, 26, 1.00),
(6, 3, 1.00),
(6, 2, 1.00),
(6, 27, 1.00),
(6, 28, 1.00),
(6, 29, 1.00),
(6, 30, 1.00),
(6, 31, 1.00);

insert into Meal_plan (meal_plan_id, user_id, start_date) values
(1, 1, '2026-02-17');

insert into Planned_meal (planned_meal_id, meal_plan_id, date, meal_type) values
(1, 1, '2026-02-17', 'dinner'),
(2, 1, '2026-02-18', 'dinner'),
(3, 1, '2026-02-19', 'dinner'),
(4, 1, '2026-02-20', 'dinner'),
(5, 1, '2026-02-21', 'dinner'),
(6, 1, '2026-02-22', 'dinner'),
(7, 1, '2026-02-23', 'dinner');

insert into Planned_meal_recipe (planned_meal_id, recipe_id) values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 1);

insert into Inventory (inventory_item_id, user_id, ingredient_id, quantity_on_hand, expiration_date) values
(1, 1, 5, 2, '2026-05-21'),
(2, 1, 19, 2, '2026-06-07'),
(3, 1, 28, 1, '2026-03-11'),
(4, 1, 26, 2, '2026-03-02'),
(5, 1, 25, 2, '2026-04-23'),
(6, 1, 3, 3, '2026-06-04'),
(7, 1, 9, 1, '2026-05-27'),
(8, 1, 4, 2, '2026-04-02'),
(9, 1, 16, 3, '2026-06-09'),
(10, 1, 15, 1, '2026-05-13');

insert into GroceryList (grocery_list_id, user_id) values
(1, 1);

insert into Grocery_list_item (grocery_list_id, ingredient_id, quantity_needed, covered_by_inventory) values
(1, 3, 3, 0),
(1, 1, 2, 0),
(1, 5, 0, 1),
(1, 6, 3, 0),
(1, 7, 2, 0),
(1, 2, 3, 0),
(1, 8, 1, 0),
(1, 4, 1, 0),
(1, 9, 0, 1),
(1, 10, 1, 0),
(1, 11, 1, 0),
(1, 12, 1, 0),
(1, 13, 1, 0),
(1, 14, 1, 0),
(1, 15, 0, 1),
(1, 16, 0, 1),
(1, 17, 1, 0),
(1, 18, 1, 0),
(1, 19, 0, 1),
(1, 20, 1, 0),
(1, 21, 1, 0),
(1, 22, 1, 0),
(1, 23, 1, 0),
(1, 24, 1, 0),
(1, 25, 0, 1),
(1, 26, 0, 1),
(1, 27, 1, 0),
(1, 28, 0, 1),
(1, 29, 1, 0),
(1, 30, 1, 0),
(1, 31, 1, 0);