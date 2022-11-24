require_relative 'users'

class UserRepository
  def all
    sql = 'SELECT id, email, username FROM users;'
    result_set = DatabaseConnection.exec_params(sql, [])
    users = []

    result_set.each do |record|
      user = User.new
      user.id = record['id']
      user.email = record['email']
      user.username = record['username']
      users << user
    end
    users
  end 

  def find(id)
    sql = 'SELECT id, email, username FROM users WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)

    record = result_set[0]
    user = User.new
    user.id = record['id']
    user.email = record['email']
    user.username = record['username']

    user
  end

  def create(user)
    sql = 'INSERT INTO users (email, username) VALUES ($1, $2);'
    params = [user.email, user.username]
    DatabaseConnection.exec_params(sql, params)
  end

  def delete(id)
    sql = 'DELETE FROM users WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end

end 