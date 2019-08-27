require 'rspec'
require 'song'
require 'album'
require 'pry'

describe('#Song') do

  before(:each) do
    Album.clear()
    Song.clear()
    @album = Album.new({:name => "Air for Free", :artist => "Relient K", :year => 2016, :genre => "Alt", :length => "01:16:23", :id => 2})
    @album.save()
    @song = Song.new({name: "Where the Light Shines Through", album_id: @album.id, songwriter: "Jon Forman", lyrics: "If the house burns down tonight!"})
    @song.save()
    @song2 = Song.new({name: "Candlelight", album_id: @album.id, songwriter: "Matt Theisson", lyrics: "To know here is to love her."})
    @song2.save()
  end
  
  describe('#==') do
  it("is the same song if it has the same attributes as another song") do
    @song2 = Song.new({name: "Where the Light Shines Through", album_id: @album.id, songwriter: "Jon Forman", lyrics: "If the house burns down tonight!"})
    @song2.save()
    expect(@song).to(eq(@song2))
  end
end

  describe('#album') do
    it("finds the album a song belongs to") do
      @song.save()
      expect(@song.album()).to(eq(@album))
    end
  end

  describe('.all') do
    it("returns a list of all songs") do
      expect(Song.all).to(eq([@song, @song2]))
    end
  end

  describe('.find_by_album') do
    it("finds songs for an album") do
      album2 = Album.new({name: "Blue"})
      album2.save
      @song2 = Song.new({name: "California", album_id: album2.id})
      @song2.save()
      expect(Song.find_by_album(album2.id)).to(eq([@song2]))
    end
  end

  describe('.clear') do
    it("clears all songs") do
      Song.clear()
      expect(Song.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a song") do
      expect(Song.all).to(eq([@song, @song2]))
    end
  end

  describe('.find') do
    it("finds a song by id") do
      expect(Song.find(@song.id)).to(eq(@song))
      expect(Song.find(@song2.id)).to(eq(@song2))
    end
  end

  describe('#update') do
    it("updates an song by id") do
      @song = @song.update({name: "Mr. P.C."})
      expect(@song.name).to(eq("Mr. P.C."))
    end
  end

  describe('#delete') do
    it("deletes an song by id") do
      @song.delete()
      expect(Song.all).to(eq([@song2]))
    end
  end
end