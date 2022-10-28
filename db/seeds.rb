# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'json'
require 'open-uri'

puts 'Cleaning database...'
Movie.destroy_all
puts 'Creating movies...'

url = "https://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.open(url).read
movies_hashes = JSON.parse(movies_serialized)["results"]
movies_hashes.each do |movie|
  Movie.create(title: movie["original_title"],
               overview: movie["overview"],
               poster_url: movie["poster_path"],
               rating: movie["vote_average"])
end

url = "https://tmdb.lewagon.com/movie/popular"
movies_serialized = URI.open(url).read
movies_hashes = JSON.parse(movies_serialized)["results"]
movies_hashes.each do |movie|
  Movie.create(title: movie["original_title"],
               overview: movie["overview"],
               poster_url: movie["poster_path"],
               rating: movie["vote_average"])
end

url = "https://tmdb.lewagon.com/movie/upcoming"
movies_serialized = URI.open(url).read
movies_hashes = JSON.parse(movies_serialized)["results"]
movies_hashes.each do |movie|
  Movie.create(title: movie["original_title"],
               overview: movie["overview"],
               poster_url: movie["poster_path"],
               rating: movie["vote_average"])
end

url = "https://tmdb.lewagon.com/movie/now_playing"
movies_serialized = URI.open(url).read
movies_hashes = JSON.parse(movies_serialized)["results"]
movies_hashes.each do |movie|
  Movie.create(title: movie["original_title"],
               overview: movie["overview"],
               poster_url: movie["poster_path"],
               rating: movie["vote_average"])
end

puts "Finished! #{Movie.count} movies created"
