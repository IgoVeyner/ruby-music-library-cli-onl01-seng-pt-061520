require 'pry'

class Artist 
  attr_accessor :songs, :name

  extend Concerns::Findable

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
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

  def add_song(song)
    song.artist = self unless song.artist
    songs << song unless self.songs.include?(song)
  end

  def genres
    songs.map {|song| song.genre}.uniq
  end
end

# binding.pry