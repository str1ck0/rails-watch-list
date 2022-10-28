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
Bookmark.destroy_all
Movie.destroy_all
puts 'Creating movies...'

url = "https://tmdb.lewagon.com/movie/top_rated"
data_serialized = URI.open(url).read
data = JSON.parse(data_serialized)

relevant_infos = data["results"]

relevant_infos.each do |info|
  poster_url = "https://image.tmdb.org/t/p/original/#{info["poster_path"]}"
  file = URI.open(poster_url)

  movie = Movie.new(title: info["original_title"],
                    overview: info["overview"],
                    poster_url: poster_url,
                    rating: info["vote_average"])
  movie.photo.attach(io: file, filename: "#{info["original_title"].gsub(" ", "-")}.png", content_type: "image/png")
  movie.save
end

# url = "https://tmdb.lewagon.com/movie/popular"
# movies_serialized = URI.open(url).read
# movies_hashes = JSON.parse(movies_serialized)["results"]
# movies_hashes.each do |movie|
#   Movie.create(title: movie["original_title"],
#                overview: movie["overview"],
#                poster_url: movie["poster_path"],
#                rating: movie["vote_average"])
# end

# url = "https://tmdb.lewagon.com/movie/upcoming"
# movies_serialized = URI.open(url).read
# movies_hashes = JSON.parse(movies_serialized)["results"]
# movies_hashes.each do |movie|
#   Movie.create(title: movie["original_title"],
#                overview: movie["overview"],
#                poster_url: movie["poster_path"],
#                rating: movie["vote_average"])
# end

# url = "https://tmdb.lewagon.com/movie/now_playing"
# movies_serialized = URI.open(url).read
# movies_hashes = JSON.parse(movies_serialized)["results"]
# movies_hashes.each do |movie|
#   Movie.create(title: movie["original_title"],
#                overview: movie["overview"],
#                poster_url: movie["poster_path"],
#                rating: movie["vote_average"])
# end

puts "Finished! #{Movie.count} movies created"
