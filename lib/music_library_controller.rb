require 'pry'

class MusicLibraryController
  attr_accessor :path, :music_importer

  def initialize(path = './db/mp3s')
    @path = path
    # Artist.destroy_all
    # Song.destroy_all
    # Genre.destroy_all
    @music_importer = MusicImporter.new(path)
    @music_importer.import
  end

  def self.all
    @@all
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.chomp
    list_songs if input == "list songs"
    list_artists if input == "list artists"
    list_genres if input == "list genres"
    list_songs_by_artist if input == "list artist"
    list_songs_by_genre if input == "list genre"
    play_song if input == "play song"
    input == "exit" ? return : call
  end

  def get_file_names
    music_importer.files.map{|file| file.gsub(".mp3", "")}
  end

  def split_file_array
    get_file_names.map{|file| file.split(" - ")}
  end

  def sort_file_array
    split_file_array.sort_by {|file| file[1]}
  end

  def join_file_array(sorted_array)
    sorted_array.map{|file| file.join(" - ")}
  end

  def list_songs
    join_file_array(sort_file_array).each_with_index{|f,i| puts "#{i+1}. #{f}"}
  end

  def list_artists
    Artist.all_artist_names.uniq.sort.each_with_index{|a,i| puts "#{i+1}. #{a}"}
  end
  
  def list_genres
    Genre.all_genre_names.uniq.sort.each_with_index{|g,i| puts "#{i+1}. #{g}"}
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = gets.chomp
    if Artist.find_by_name(artist)
      artist_genre_hash = {} 
      Artist.find_by_name(artist).songs.map {|song| artist_genre_hash[song.name] = song.genre.name } # Fill hash with artist name & genre
      artist_genre_hash.sort.each_with_index{|(k,v),i| puts "#{i+1}. #{k} - #{v}"}
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = gets.chomp
    if Genre.find_by_name(genre)
      artist_song_hash = {}
      Genre.find_by_name(genre).songs.map{|song| artist_song_hash[song.artist.name] = song.name} # fills hash
      artist_song_hash.sort_by(&:last).each_with_index{|(k,v),i| puts "#{i+1}. #{k} - #{v}"}
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets

    filename = join_file_array(sort_file_array)
    index = input_to_index(input)

    if index >= 0 && index < filename.length
      parsed = filename[index].split(" - ")
      puts "Playing #{parsed[1]} by #{parsed[0]}"
    end
  end

  def input_to_index(input)
    input.to_i - 1
  end

  

end
