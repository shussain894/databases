# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

_In this template, we'll use an example table `students`_

```
# EXAMPLE
Table: users
Columns:
id | email | username

Table: posts
Columns:
id | title | content | views | user_id

```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)
-- Write your SQL seed here.
-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)
TRUNCATE TABLE users RESTART IDENTITY CASCADE; -- replace with your own table name.
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO users (username, email) VALUES ('shahhussain', 'shah@test.com');
INSERT INTO users (username, email) VALUES ('ishowspeed', 'speed@test.com');


-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE posts RESTART IDENTITY CASCADE; -- replace with your own table name.
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, views, user_id) VALUES ('day1', 'makers', 5, '1');
INSERT INTO posts (title, content, views, user_id) VALUES ('day2', 'golden square', 10, '2');

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network_test < seeds_users.sql
psql -h 127.0.0.1 social_network_test < seeds_posts.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: users
# Model class
# (in lib/user.rb)
class User
end
# Repository class
# (in lib/user_repository.rb)
class UserRepository
end


# (in lib/post.rb)
class Post
end
# Repository class
# (in lib/post_repository.rb)
class PostRepository
end


```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students
# Model class
# (in lib/user.rb)
class User
  # Replace the attributes by your own columns.
  attr_accessor :id, :email, :username
end
# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Shah'
# student.name

# (in lib/post.rb)
class Post
  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :views, :user_id
end

```

_You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed._

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: users
# Repository class
# (in lib/user_repository.rb)
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
```

```ruby
# EXAMPLE
# Table name: posts
# Repository class
# (in lib/post_repository.rb)
class PostsRepository
  
  def all
    sql = 'SELECT id, title, content, views, user_id FROM posts;'
    result_set = DatabaseConnection.exec_params(sql, [])
    posts = []
    
    result_set.each do |record|
      post = Post.new
      post.id = record['id']
      post.title = record['title']
      post.content = record['content']
      post.views = record['views']
      post.user_id = record['user_id']
      posts << post
    end
    posts
  end

  def find(id)
    sql = 'SELECT id, title, content, views, user_id FROM posts WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    post = Post.new
    post.id = record['id']
    post.title = record['title']
    post.content = record['content']
    post.views = record['views']
    post.user_id = record['user_id']
    post
  end

  def create(post)
    sql = 'INSERT INTO posts (title, content, views, user_id) VALUES ($1, $2, $3, $4);'
    params = [post.title, post.content, post.views, post.user_id]
    DatabaseConnection.exec_params(sql, params)
  end

  def delete(id)
    sql = 'DELETE FROM posts WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES
# 1
# Get all users
repo = UserRepository.new
users = repo.all
expect(users.length).to eq 2
expect(users[0].id).to eq '1'
expect(users[0].username).to eq 'shahhussain'
expect(users[0].email).to eq 'shah@test.com'
expect(users[1].id).to eq '2'
expect(users[1].username).to eq 'ishowspeed'
expect(users[1].email).to eq 'speed@test.com'

# 2
# Get a single user
repo = UserRepository.new
users = repo.find(1)
expect(users.id).to eq 1
expect(users.username).to eq 'shahhussain'
expect(users.email).to eq'shah@test.com'

# 3
# create a user
repo = UserRepository.new
new_user = User.new
new_user.email = 'ronaldo@test.com'
new_user.username = 'ronaldo'

repo.create(new_user).to eq nil
users = repo.all
last_user = users.last

expect(last_user.email).to eq 'ronaldo@test.com'
expect(last_user.username).to eq 'ronaldo'

# 4
# delete a user
repo = UserRepository.new
repo.delete(1)
result_set = repo.all

expect(result_set.length).to eq 1
expect(result_set.first.id).to eq '2'

# 6
# Get all posts
repo = PostRepository.new
posts = repo.all
posts.length.to eq 2
expect(posts.length).to eq 2
expect(posts[0].id).to eq '1'
expect(posts[0].title).to eq 'day1'
expect(posts[0].content).to eq 'makers'
expect(posts[0].views).to eq 5
expect(posts[0].user_id).to eq 1

# 7 
# finds a post
  repo = PostsRepository.new
  posts = repo.find(1)
  expect(posts.title).to eq 'day1'
  expect(posts.content).to eq 'makers'
  expect(posts.views).to eq '5'
  expect(posts.user_id).to eq '1'

# 8
# creates a post
repo = PostsRepository.new
new_post = Post.new
new_post.title = 'new post'
new_post.content = 'masteryquiz'
new_post.views = '10'
new_post.user_id = '1'

repo.create(new_post)

posts = repo.all
last_post = posts.last

expect(last_post.title).to eq 'new post'
expect(last_post.content).to eq 'masteryquiz'
expect(last_post.views).to eq '10'
expect(last_post.user_id).to eq '1'


# 7
# delete a post
repo = PostsRepository.new
repo.delete(1)

result_set = repo.all
expect(result_set.length).to eq 1
expect(result_set.first.id).to eq '2'

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE
# file: spec/user_repository_spec.rb
def reset_users_table
  seed_sql = File.read('spec/seeds_users.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

  before(:each) do
    reset_users_table
  end
  # (your tests will go here).
end

# file: spec/post_repository_spec.rb
def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

  before(:each) do
    reset_posts_table
  end
  # (your tests will go here).


```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._