# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.create!(name: "Elle",
    username: "unrxvl",
    email: "elle@mail.com",
    password: "password")

5.times do |n|
    name = Faker::Name.name
    username = "username#{n+1}"
    email = "name#{n+1}@mail.com"
    password = "password"
    User.create!(name: name,
                email: email,
                username: username,
                password: password,
                password_confirmation: password)
end