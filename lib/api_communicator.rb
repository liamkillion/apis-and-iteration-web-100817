require 'rest-client'
require 'json'
require 'pry'

#make the web request
# iterate over the character hash to find the collection of `films` for the given
#   `character`
# collect those film API urls, make a web request to each URL to get the info
#  for that film
# return value of this method should be collection of info about each film.
#  i.e. an array of hashes in which each hash reps a given film
# this collection will be the argument given to `parse_character_movies`
#  and that method will do some nice presentation stuff: puts out a list
#  of movies by title. play around with puts out other info about a given film.

def get_character_movies_from_api(character)
  our_character = find_specific_character(character)
  films = our_character["films"]
  films.map do |film|
    film_data=RestClient.get(film)
    film_hash = JSON.parse(film_data)
  end
end

def find_specific_character(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  character_hash["results"].find {|char_hash| char_hash["name"] == character}
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  # def print_books(book_hashes)
  #   #for each book hash, print out name/title/subtitle/description
  #   book_hashes.each_with_index do |book_hash,index|
  #     puts "#{index+1}. #{book_hash[:title]}"
  #     puts "#{book_hash[:subtitle]}"
  #     puts "#{book_hash[:description]}"
  #     puts "#{book_hash[:authors]}"
  #     puts
  #   end
  # end
  films_hash=films_hash.sort_by {|film_hash| film_hash["episode_id"]}
  films_hash.each do |film_hash|
    puts "Title: #{film_hash["title"]}"
    puts "Episode ID: #{film_hash["episode_id"]}"
    puts "Directed by #{film_hash["director"]}"
    puts "Produced by #{film_hash["producer"]}"
    puts "Released on #{film_hash["release_date"]}"
    puts
  end
end

def show_character_movies(character)
  if find_specific_character(character)== nil
    puts "No Results Founds!"
  else
    films_hash = get_character_movies_from_api(character)
    parse_character_movies(films_hash)
  end
end

def find_specific_film(film_title)
  all_films = RestClient.get('http://www.swapi.co/api/films/')
  films_hash = JSON.parse(all_films)
  films_hash["results"].find {|film_hash| film_hash["title"] == film_title}
end

def show_film(film_title)
  if find_specific_film(film_title)== nil
    puts "No Results Founds!"
  else
    film_hash = find_specific_film(film_title)
      puts "Title: #{film_hash["title"]}"
      puts "Episode ID: #{film_hash["episode_id"]}"
      puts "Directed by #{film_hash["director"]}"
      puts "Produced by #{film_hash["producer"]}"
      puts "Released on #{film_hash["release_date"]}"
      puts
  end
end

def parse_film(film_title)
  films_hash=films_hash.sort_by {|film_hash| film_hash["episode_id"]}
  films_hash.each do |film_hash|
    puts "Title: #{film_hash["title"]}"
    puts "Episode ID: #{film_hash["episode_id"]}"
    puts "Directed by #{film_hash["director"]}"
    puts "Produced by #{film_hash["producer"]}"
    puts "Released on #{film_hash["release_date"]}"
    puts
  end
end
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
