class Album
  attr_accessor :name, :artist, :year, :genre, :length, :id
  @@albums = {}
  @@sold_albums = {}
  @@total_rows = 0

  def initialize(attributes)
    attributes.each { |key, value| send "#{key}=", value }
    @id = attributes.fetch(:id) { @@total_rows+=1 }
  end
  
  def self.all
    @@albums.values()
  end
  
  def save
    @@albums[self.id] = Album.new({name: self.name, artist: self.artist, year: self.year, genre: self.genre, length: self.length, id: self.id})
  end

  def save_sold
    @@sold_albums[self.id] = Album.new({name: self.name, artist: self.artist, year: self.year, genre: self.genre, length: self.length, id: self.id})
  end
  
  def sell
    @@sold_albums[self.id] = @@albums[self.id] 
    @@albums.delete(self.id)
  end

  def self.sold
    @@sold_albums.values
  end

  def songs
    Song.find_by_album(self.id)
  end

  def is_sold?
    @@sold_albums[self.id] ? true : false
  end

  def self.search(name)
    @@albums.values.select {|a| a.name == name }
  end

  def self.sort
    array = @@albums.sort_by {|k,v| v.name.downcase}
    array.to_h.values
  end

  def ==(album_to_compare)
    self.name == album_to_compare.name
  end

  def self.clear
    @@albums = {}
    @@sold_albums = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@albums[id] || @@sold_albums[id]
  end

  def update(new_attributes)
    if self.is_sold?
      @@sold_albums[self.id] = Album.new(new_attributes)
    else
      @@albums[self.id] = Album.new(new_attributes)
    end
  end

  def delete()
    if self.is_sold?
      @@sold_albums.delete(self.id)
    else
      @@albums.delete(self.id)
    end
  end
end
