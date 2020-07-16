require 'pry'

class Song < BasicCommands
  attr_reader :artist, :genre

  extend Concerns::Findable

  def initialize(name, artist = nil, genre = nil)
    super(name)
    self.artist = artist if artist != nil
    self.genre = genre if genre != nil
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