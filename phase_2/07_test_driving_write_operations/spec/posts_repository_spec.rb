require 'posts_repository'

RSpec.describe PostsRepository do
  def reset_posts_table
    seed_sql = File.read('spec/seeds_posts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end
  
    before(:each) do
      reset_posts_table
    end

  it "returns all the posts" do
    repo = PostsRepository.new
    posts = repo.all
    expect(posts.length).to eq 2
    expect(posts[0].id).to eq '1'
    expect(posts[0].title).to eq 'day1'
    expect(posts[0].content).to eq 'makers'
    expect(posts[0].views).to eq '5'
    expect(posts[0].user_id).to eq '1'
  end

  it "finds a specific post" do
    repo = PostsRepository.new
    posts = repo.find(1)
    expect(posts.title).to eq 'day1'
    expect(posts.content).to eq 'makers'
    expect(posts.views).to eq '5'
    expect(posts.user_id).to eq '1'
  end 

  it "creates a post" do
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
  end 

  it "deletes a post" do
    repo = PostsRepository.new
    repo.delete(1)

    result_set = repo.all
    expect(result_set.length).to eq 1
    expect(result_set.first.id).to eq '2'
  end 


end 