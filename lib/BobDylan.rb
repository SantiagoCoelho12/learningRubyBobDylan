require_relative 'FileReader.rb'
require_relative 'Album.rb'
require_relative 'api/Spotify.rb'
Dotenv.load

fr = FileReader.new
spotify_api = Spotify.new
disc_file = ENV['disc_file']
lines = fr.read(disc_file)

hash_album = {}
lines.each do |line|
    data = line.split(' ',2)
    cover = spotify_api.get_album_cover("Bob Dylan - #{data[0]} #{data[1]}")
    album = Album.new(data[0], data[1], cover)
    hash_album[album.decade] ||= []
    hash_album[album.decade] << album
end

hash_album.each do |clave, valor|
    valor.sort!
end
