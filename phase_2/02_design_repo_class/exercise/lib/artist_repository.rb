class ArtistRepository
  def all
    sql = 'SELECT name, genre FROM artists;'
    result_set = DatabaseConnection.exec_params(sql, [])

    artists = []

    result_set.each do |record|
      artist = artist.new
      artist.id = record['id']
      artist.name = record['name']
      artist.genre = record['genre']

      artists << artist 
    end
    artists 
  end 
end 

## i did not use this 