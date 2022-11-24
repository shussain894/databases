require 'recipes_directory'

RSpec.describe RecipesDirectory do

  def reset_recipes_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_recipes_table
  end   
  it "returns the first recipe + details" do
    repo = RecipesDirectory.new
    recipe = repo.all
    expect(recipe.first.name).to eq 'Chicken'
    expect(recipe.first.time).to eq '40'
    expect(recipe.first.rating).to eq '10'
  end

  it "returns the 2nd recipe details" do
    repo = RecipesDirectory.new
    recipe = repo.find(2)
    expect(recipe.name).to eq 'Steak'
    expect(recipe.time).to eq '20'
    expect(recipe.rating).to eq '9'
  end
end 