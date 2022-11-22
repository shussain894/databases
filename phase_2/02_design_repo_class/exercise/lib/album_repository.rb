require 'album'

class AlbumRepository
  def all
    sql = 'SELECT title, release_year, artist_id FROM albums;'
    result_set = DatabaseConnection.exec_params(sql, [])

    albums = []

    result_set.each do |record|
      album = Album.new
      album.id = record['id']
      album.title = record['title']
      album.artist_id = record['artist_id']
      album.release_year = record['release_year']

      albums << album 
    end
    albums 
  end
end 