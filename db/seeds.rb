# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Comment.destroy_all
Tweet.destroy_all
User.destroy_all
p "Sedding users"
user = User.new
user.email = "admin@gmail.com"
user.username = "Admin"
user.name = "Admin Master of all"
user.password = "123456"
user.password_confirmation = "123456"
user.save
rand(3..5).times do 
  user = User.new
  user.email = Faker::Internet.unique.email
  user.username = Faker::Games::LeagueOfLegends.unique.champion
  user.name = Faker::Name.unique.name
  user.password = "123456"
  user.password_confirmation = "123456"
  user.save
end
p "Done users"
p "Sedding Tweets"
User.all.each do |user|
  rand(3..5).times do 
    tweet = Tweet.new
    tweet.body = Faker::Games::LeagueOfLegends.quote 
    tweet.user = user
    tweet.save
  end
end
p "Done Tweets"
p "Sedding Comments"
users = User.all
Tweet.all.each do |tweet|
  rand(3..5).times do 
    comment = Comment.new
    comment.body = Faker::Games::WarhammerFantasy.quote
    comment.tweet = tweet
    comment.user = users.sample
    comment.save
  end
end
p "Done Comments"