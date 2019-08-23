class Song
  attr_accessor :name, :album_id, :songwriter, :lyrics, :id

  @@songs = {}
  @@total_rows = 0

  def initialize(attributes)
    attributes.each { |key, value| send "#{key}=", value }
    attributes.key?(:id) ? @id = attributes.fetch(:id) : @id = @@total_rows+=1
  end

  def ==(song_to_compare)
    (self.name() == song_to_compare.name()) && (self.album_id() == song_to_compare.album_id())
  end

  def album
    Album.find(self.album_id)
  end
  
  def self.all
    @@songs.values
  end

  def save
    @@songs[self.id] = Song.new({name: self.name, album_id: self.album_id, songwriter: self.songwriter, lyrics: self.lyrics, id: self.id})
  end

  def self.find(id)
    puts @@songs
    @@songs[id]
  end

  def self.find_by_album(alb_id)
    songs = []
    @@songs.values.each do |song|
      if song.album_id == alb_id
        songs.push(song)
      end
    end
    songs
  end

  def update(new_attributes)
    @@songs[self.id] = Song.new(new_attributes)
  end

  def delete
    @@songs.delete(self.id)
  end

  def self.clear
    @@songs = {}
  end
end