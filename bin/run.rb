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
    show_character_movies(character)
  elsif response == "exit"
    break
  end
end
