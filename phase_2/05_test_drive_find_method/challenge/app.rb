require_relative 'lib/database_connection'
require_relative 'lib/recipes_directory'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipes_directory_test')

# puts 2nd recipe details
recipes_directory = RecipesDirectory.new 
recipe = recipes_directory.find(2)

puts recipe.name
puts recipe.time
puts recipe.rating 


# Perform a SQL query on the database and get the result set.
sql = 'SELECT id, name, time, rating FROM recipes;'
result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
result.each do |record|
  p record
end

