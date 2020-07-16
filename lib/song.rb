require 'pry'

class Song
  attr_accessor :artist, :genre, :name

  extend Concerns::Findable

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist != nil
    self.genre = genre if genre != nil
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    x = self.new(name)
    x.save
    x
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self if !genre.songs.include?(self)
  end

  def self.new_from_filename(filename)
    parsed = filename.split(" - ")
    song = Song.find_or_create_by_name(parsed[1])
    song.artist = Artist.find_or_create_by_name(parsed[0])
    song.genre = Genre.find_or_create_by_name(parsed[2].gsub(".mp3", ""))
    song
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).save
  end
end

# binding.pry