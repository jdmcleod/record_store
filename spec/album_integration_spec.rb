require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('#album') do

  before(:each) do
    @album = Album.new({name: "Yellow Submarine"})
    @album.save
  end

  describe('create an album path', {:type => :feature}) do
    it('creates an album and then goes to the album page') do
      visit('/albums')
      click_on('Add a new album')
      fill_in('album_name', :with => 'Yellow Submarine')
      click_on('Create album')
      expect(page).to have_content('Yellow Submarine')
    end
  end

  describe('return to albums path', {:type => :feature}) do
      it('vists edit album page and then return to albums page') do
        visit("/albums/#{@album.id}")
        click_on("Return to album list")
        expect(page).to have_content("Available Records")
    end
  end

  describe('edit an album path', {:type => :feature}) do
    it('goes to album edit page') do
      visit("/albums/#{@album.id}")
      click_on('Edit Album')
      expect(page).to have_content('Change name')
    end
  end

  describe('buy an album path', {:type => :feature}) do
    it('goes to buy album page') do
      visit("/albums/#{@album.id}")
      click_on('Buy this album')
      expect(page).to have_content('Price $')
      fill_in('price', :with => "10")
      click_on('Buy Album')
      expect(page).to have_content("Sold Records\n#{@album.name}")
    end
  end

  describe('delete album path', {:type => :feature}) do
    it('delets album and returns to albums list') do
      visit("/albums/#{@album.id}")
      click_on('Edit Album')
      click_on('Delete album')
      expect(page).to have_content('Available Records')
    end
  end

  describe('create a song path', {:type => :feature}) do
    it('creates an album and then goes to the album page') do
      visit("/albums/#{@album.id}")
      fill_in('song_name', :with => 'All You Need Is Love')
      click_on('Add song')
      expect(page).to have_content('All You Need Is Love')
    end
  end

end