require 'album_repository.rb'

RSpec.describe AlbumRepository do

  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_albums_table
  end   

  it "returns the album info" do
    repo = AlbumRepository.new
    albums = repo.all
    expect(albums.length).to eq 2
    expect(albums.first.title).to eq 'Red'
    expect(albums.first.release_year).to eq '2010'
    expect(albums.first.artist_id).to eq '3'
  end

  it "returns the first album" do
    repo = AlbumRepository.new
    album = repo.find(1)
    expect(album.id).to eq '1'
    expect(album.title).to eq 'Red'
    expect(album.release_year).to eq '2010'
    expect(album.artist_id).to eq '3'
  end

  it "creates a new album" do
    repository = AlbumRepository.new
    album = Album.new
    album.title = 'Trompe le Monde'
    album.release_year = 1991
    album.artist_id = 1

    repository.create(album)
    all_albums = repository.all
    last_album = all_albums.last 
    expect(last_album.title).to eq 'Trompe le Monde'
    expect(last_album.release_year).to eq '1991'
  end 

end 

