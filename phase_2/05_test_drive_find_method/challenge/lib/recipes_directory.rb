require_relative 'recipes'

class RecipesDirectory
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
    recipes 
  end 

  def find(id) # id is passed in from the test repo.find(2)
    sql = 'SELECT id, name, time, rating FROM recipes WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0] # this should be 0 and not 1 as the array only returns 1 value
    
      recipe = Recipes.new
      recipe.id = record['id']
      recipe.name = record['name']
      recipe.time = record['time']
      recipe.rating = record['rating']
      
    recipe
  end 
end 