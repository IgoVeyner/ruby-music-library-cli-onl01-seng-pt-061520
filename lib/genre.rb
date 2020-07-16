require 'pry'

class Genre 
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

  def artists
    songs.map {|song| song.artist}.uniq
  end

  def self.create(name)
    x = self.new(name)
    x.save
    x
  end
end

# binding.pry