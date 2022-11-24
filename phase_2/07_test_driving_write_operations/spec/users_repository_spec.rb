require 'users_repository'

RSpec.describe UserRepository do
  def reset_users_table
    seed_sql = File.read('spec/seeds_users.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end
  
    before(:each) do
      reset_users_table
    end

  it "returns all the users" do
    repo = UserRepository.new
    users = repo.all
    expect(users.length).to eq 2
    expect(users[0].id).to eq '1'
    expect(users[0].username).to eq 'shahhussain'
    expect(users[0].email).to eq 'shah@test.com'
    expect(users[1].id).to eq '2'
    expect(users[1].username).to eq 'ishowspeed'
    expect(users[1].email).to eq 'speed@test.com'
  end

  it "returns a single user" do
    repo = UserRepository.new
    users = repo.find(1)
    expect(users.id).to eq '1'
    expect(users.username).to eq 'shahhussain'
    expect(users.email).to eq'shah@test.com'
  end 

  it "creates a new user" do
    repo = UserRepository.new
    new_user = User.new
    new_user.email = 'ronaldo@test.com'
    new_user.username = 'ronaldo'

    repo.create(new_user)
    users = repo.all
    last_user = users.last

    expect(last_user.email).to eq 'ronaldo@test.com'
    expect(last_user.username).to eq 'ronaldo'
  end 

  it "deletes a user" do
    repo = UserRepository.new
    repo.delete(1)
    result_set = repo.all

    expect(result_set.length).to eq 1
    expect(result_set.first.id).to eq '2'
  end 
end
