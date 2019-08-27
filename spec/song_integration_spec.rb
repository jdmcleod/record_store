require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('#song') do

  before(:each) do
    @album = Album.new({:name => "In Rainbows", :artist => "Radiohead", :year => 2007, :genre => "Rock", :length => "42:39"})
    @album.save()
    @song = Song.new({name: "Where the Light Shines Through", album_id: @album.id, songwriter: "Jon Forman", lyrics: "If the house burns down tonight!"})
    @song.save()  
  end

  describe('edit song path', {:type => :feature}) do
    it('vists edit song page') do
      visit("/albums/#{@album.id}/songs/#{@song.id}")
      click_on('Edit song')
      expect(page).to have_content('Change Songwriter')
    end
  end

  describe('return to album path', {:type => :feature}) do
    it('goes to edit song page and returns to ablum pages') do
      visit("/albums/#{@album.id}/songs/#{@song.id}")
      click_on("Back to #{@album.name}")
      expect(page).to have_content("Album Name: #{@album.name}")
    end
  end

  describe('delete song path', {:type => :feature}) do
    it('deletes song and returns to album page') do
      visit("/albums/#{@album.id}/songs/#{@song.id}")
      click_on('Delete song')
      expect(page).to have_content("Album Name: #{@album.name}")
    end
  end

  describe('update song path', {:type => :feature}) do
    it('creates an song and edits the songwriter') do
      visit("/albums/#{@album.id}/songs/#{@song.id}")
      click_on('Edit song')
      fill_in('songwriter', :with => 'Toby Mac')
      click_on('Update')
      expect(page).to have_content("Songwriter: Toby Mac")
    end
  end

  describe('cancel update song path', {:type => :feature}) do
    it('edit song and then cancel returning to album page') do
      visit("/albums/#{@album.id}/songs/#{@song.id}")
      click_on('Edit song')
      fill_in('songwriter', :with => 'Toby Mac')
      click_on('Cancel')
      expect(page).to have_content("Songwriter: Jon Forman")
    end
  end

end
