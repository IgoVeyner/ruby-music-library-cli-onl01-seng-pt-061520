class Genre < BasicCommands
  attr_accessor :songs
  
  extend Concerns::Findable

  @@all_genre_names = []

  def initialize(name)
    super(name)
    @songs = []
  end

  def artists
    songs.map {|song| song.artist}.uniq
  end

  def self.all_genre_names
    @@all_genre_names
  end

  def self.destroy_all
    super
    @@all_genre_names.clear
  end

  def save
    super
    @@all_genre_names << @name
  end
end

# binding.pry