require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('./lib/song')
require('pry')
also_reload('lib/**/*.rb')


def initialize_albums
  @albums = Album.sort
  @sold_albums = Album.sold
end

get('/') do
  initialize_albums
  erb(:albums)
end

get('/albums') do
  initialize_albums
  erb(:albums)
end

get('/albums/new') do
  erb(:new_album)
end

get('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

get '/search'  do
  initialize_albums
  @albums = Album.search(params[:search]) if params[:search]
  erb(:results)
end

post('/albums') do
  name = params[:album_name]
  artist = params[:artist]
  album = Album.new({name: name, artist: artist})
  album.save()
  initialize_albums
  erb(:albums)
end

get('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update({name: params[:new_name], id: @album.id})
  initialize_albums
  erb(:albums)
end

delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  initialize_albums
  erb(:albums)
end

get('/albums/:id/buy') do
  @album = Album.find(params[:id].to_i)
  erb(:buy)
end

post('/albums/:id/buy') do
  @album = Album.find(params[:id].to_i)
  @album.sell
  @album.save_sold
  initialize_albums
  erb(:albums)
end

get('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end

post('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())
  song = Song.new({name: params[:song_name], album_id: @album.id})
  song.save()
  erb(:album)
end

get('/albums/:id/songs/:song_id/edit') do
  @album = Album.find(params[:id].to_i())
  @song = Song.find(params[:song_id].to_i())
  erb(:edit_song)
end

patch('/albums/:id/songs/:song_id/edit') do
  @album = Album.find(params[:id].to_i())
  @song = Song.find(params[:song_id].to_i())
  @song = @song.update({name: params[:new_name], album_id: @album.id, songwriter: params[:songwriter], lyrics: params[:lyrics], id: @song.id})
  erb(:song)
end

delete('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

