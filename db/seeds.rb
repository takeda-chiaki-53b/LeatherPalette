# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
p '==================== user post data create ===================='
10.times do |n|
    User.create!(
        name: "テストユーザー#{n}",
        email: "test#{n}@email.com",
        password: "password",
        password_confirmation: "password"
    )
end

user_ids = User.ids

100.times do |index|
  user = User.find(user_ids.sample)
  user.posts.create!(
    body: "本文#{index}",
    status: "published"
    )
end
