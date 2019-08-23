require 'rspec'
require 'album'
require 'song'

describe '#Album' do

  before(:each) do
    Album.clear()
    @album = Album.new({:name => "In Rainbows", :artist => "Radiohead", :year => 2007, :genre => "Rock", :length => "42:39"})
    @album.save()
    @album2 = Album.new({:name => "Air for Free", :artist => "Relient K", :year => 2016, :genre => "Alt", :length => "01:16:23", :id => 2})
    @album2.save()
  end

  describe('#save') do
    it("saves an album") do
      # binding.pry
      expect(Album.all).to(eq([@album, @album2]))
    end
  end

  describe("#name") do
    it("returns the name of an album") do
      expect(@album.name()).to(eq("In Rainbows"))
    end
  end
  
  describe('.all') do
    it("returns an empty array when there are no albums") do
      Album.clear()
      expect(Album.all).to(eq([]))
    end
  end

  describe('.clear') do
    it("clears all albums") do
      Album.clear()
      expect(Album.all).to(eq([]))
    end
  end

  describe('.sold') do
    it("Puts album into sold_albums and delets from albums") do
      @album2.sell()
      expect(Album.all).to(eq([@album]))
      expect(Album.sold).to(eq([@album2]))
    end
  end
  
  describe('.is_sold?') do
    it("Returns true if the album has been sold") do
      @album.sell()
      expect(@album.is_sold?).to(eq(true))
      expect(@album2.is_sold?).to(eq(false))
    end
  end

  describe('.sort') do
    it("Sorts the albums by name") do
      expect(Album.all).to(eq([@album,@album2]))
      expect(Album.sort).to(eq([@album2,@album]))
    end
  end
  
  describe('#==') do
    it("is the same album if it has the same attributes as another album") do
      album3 = Album.new({name: "Blue", id: 1})
      album4 = Album.new({name: "Blue", id: 1})
      expect(album3).to(eq(album4))
    end
  end

  describe('.find') do
    it("finds an album by id") do
      expect(Album.find(@album.id)).to(eq(@album))
    end
  end

  describe('.search') do
    it("Returns albums with given name") do
      expect(Album.search("Air for Free")).to(eq([@album2]))
      expect(Album.search("In Rainbows")).to(eq([@album]))
    end
  end

  describe('#songs') do
    it("returns an album's songs") do
      song = Song.new({name: "Where the Light Shines Through", album_id: @album.id, songwriter: "Jon Forman", lyrics: "If the house burns down tonight!"})
      song.save()
      song2 = Song.new({name: "Cousin Mary", album_id: @album.id})
      song2.save()
      expect(@album.songs).to(eq([song, song2]))
    end
  end

  describe('#update') do
    it("updates an album by id") do
      @album = @album.update({:name => "A Love Supreme", :artist => "Radiohead", :year => 2007, :genre => "Rock", :length => "42:39"})
      expect(@album.name).to(eq("A Love Supreme"))
    end
  end

  describe('#delete') do
    it("deletes an album by id") do
      @album.delete()
      expect(Album.all).to(eq([@album2]))
    end
  end

end