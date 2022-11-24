# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table
```
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_recipes.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (name, time, rating) VALUES ('Chicken', 40, 10 );
INSERT INTO recipes (name, time, rating) VALUES ('Steak', 20, 9 );
INSERT INTO recipes (name, time, rating) VALUES ('Fish', 10, 3 );
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class Recipes
end

# Repository class
# (in lib/student_repository.rb)
class RecipesRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: recipes

# Model class
# (in lib/recipes.rb)

class Recipes

  # Replace the attributes by your own columns.
  attr_accessor :name, :time, :rating # :id?
end


```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
class RecipesRepository

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT id, name, time, rating FROM recipes;'
    result_set = DatabaseConnection.exec_params(sql, [])

    recipes = []

    result_set.each do |record|
      recipe = Recipes.new
      recipe.id = record['id']
      recipe.name = record['name']
      recipe.time = record['time']
      recipe.rating = record['rating']
      
      recipes << recipe 
    end 
  end

  def find(id)
    sql = 'SELECT id, name, time, rating FROM recipes;'
    result_set = DatabaseConnection.exec_params(sql, [])

    recipes = []

    result_set.each do |record|
      recipe = Recipes.new
      recipe.id = record['id']
      recipe.name = record['name']
      recipe.time = record['time']
      recipe.rating = record['rating']
    end 
      recipes << recipe 
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES
RSpec.describe RecipesDirectory do
  it "returns the first recipe + details" do
    repo = RecipesDirectory.new
    recipe = repo.all
    expect(recipe.first.name).to eq 'Chicken'
    expect(recipe.first.time).to eq '40'
    expect(recipe.first.rating).to eq '10'
  end

  it "returns the 2nd recipe details" do
    repo = RecipesDirectory.new
    recipe = repo.find
    expect(recipe.name).to eq 'Steak'
    expect(recipe.time).to eq '20'
    expect(recipe.rating).to eq '9'
  end
end 
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_recipes_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_recipes_table
  end   

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

