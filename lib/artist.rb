require 'pry'

class Artist < BasicCommands
  attr_accessor :songs

  extend Concerns::Findable

  @@all_artist_names = []
  @@all = []

  def initialize(name)
    super(name)
    @songs = []
  end

  def add_song(song)
    song.artist = self if song.artist == nil
    songs << song if !songs.include?(song)
  end

  def genres
    songs.map {|song| song.genre}.uniq
  end

  def self.all_artist_names
    @@all_artist_names
  end

  def self.destroy_all
    super
    @@all_artist_names.clear
  end

  def save
    super
    @@all_artist_names << @name
  end
end

# binding.pry