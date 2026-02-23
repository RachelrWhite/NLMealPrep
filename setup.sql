-- ======================
-- USER
-- ======================
create table User (
    user_id bigint primary key,
    name varchar(50),
    email varchar(100)
);

-- ======================
-- MEAL PLAN
-- one user → many meal plans
-- ======================
create table Meal_plan (
    meal_plan_id bigint primary key,
    user_id bigint not null,
    start_date date,
    foreign key (user_id) references User(user_id)
);

-- ======================
-- PLANNED MEAL
-- one meal plan → many planned meals
-- ======================
create table Planned_meal (
    planned_meal_id bigint primary key,
    meal_plan_id bigint not null,
    date date,
    meal_type varchar(20),
    foreign key (meal_plan_id)
        references Meal_plan(meal_plan_id)
);

-- ======================
-- RECIPE
-- ======================
create table Recipe (
    recipe_id bigint primary key,
    name varchar(100),
    instructions text,
    servings int,
    calories bigint,
    protein bigint,
    carbs bigint,
    fat bigint,
    cook_time bigint
);

-- ======================
-- PLANNED_MEAL_RECIPE
-- (bridge: planned meal ↔ recipe)
-- ======================
create table Planned_meal_recipe (
    planned_meal_id bigint,
    recipe_id bigint,
    primary key (planned_meal_id, recipe_id),
    foreign key (planned_meal_id)
        references Planned_meal(planned_meal_id),
    foreign key (recipe_id)
        references Recipe(recipe_id)
);

-- ======================
-- INGREDIENT
-- ======================
create table Ingredient (
    ingredient_id bigint primary key,
    name varchar(100),
    cost bigint
);

-- ======================
-- RECIPE_INGREDIENT
-- (bridge: recipe ↔ ingredient)
-- ======================
create table Recipe_ingredient (
    recipe_id bigint,
    ingredient_id bigint,
    quantity decimal(10,2),
    primary key (recipe_id, ingredient_id),
    foreign key (recipe_id)
        references Recipe(recipe_id),
    foreign key (ingredient_id)
        references Ingredient(ingredient_id)
);

-- ======================
-- INVENTORY
-- what a user currently owns
-- ======================
create table Inventory (
    inventory_item_id bigint primary key,
    user_id bigint not null,
    ingredient_id bigint not null,
    quantity_on_hand bigint,
    expiration_date date,
    foreign key (user_id)
        references User(user_id),
    foreign key (ingredient_id)
        references Ingredient(ingredient_id)
);

-- ======================
-- GROCERY LIST
-- ======================
create table GroceryList (
    grocery_list_id bigint primary key,
    user_id bigint,
    foreign key (user_id)
        references User(user_id)
);

-- ======================
-- GROCERY LIST ITEMS
-- ======================
create table Grocery_list_item (
    grocery_list_id bigint,
    ingredient_id bigint,
    quantity_needed bigint,
    covered_by_inventory boolean,
    primary key (grocery_list_id, ingredient_id),
    foreign key (grocery_list_id)
        references GroceryList(grocery_list_id),
    foreign key (ingredient_id)
        references Ingredient(ingredient_id)
);
