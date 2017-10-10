#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome
loop do
  puts "Type M to search for a movie and C to search for a character, or exit to quit"
  response=gets.chomp
  if response == "M"
    film = get_movie_from_user
    show_film(film)
  elsif response == "C"
    character = get_character_from_user
    puts "Type P for personal information or L for list of movies"
    response = gets.chomp
    if response == "P"
      show_character_info(character)
    elsif response == "L"
      show_character_movies(character)
    end
  elsif response == "exit"
    break
  end
end
