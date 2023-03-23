# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
p '==================== admin user create ===================='
User.create!(
  name: 'taku300',
  email: 'fukuda.takuma695@mail.kyutech.jp',
  password: "password",
  password_confirmation: "password",
  introduction: 'fippo map作成中！！',
  is_published: true,
  avatar: File.open('./app/assets/images/user_placeholder.png')
)
p '==================== secret user create ==================='
User.create!(
  name: Faker::Name.unique.name,
  email: Faker::Internet.unique.email,
  password: "password",
  password_confirmation: "password",
  introduction: Faker::Lorem.paragraph,
  is_published: false,
)
p '==================== published user create ================'
10.times do |n|
  User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: "password",
    password_confirmation: "password",
    introduction: Faker::Lorem.paragraph,
    is_published: true,
  )
end

p '==================== species  create ======================'
SPECIES_NUMBER = 20
species = []
SPECIES_NUMBER.times do |n|
  time = Time.current
  species <<
    {
      name: Faker::Creature::Animal.unique.name,
    }
end
Species.insert_all! species, returning: nil

p '==================== fishes  create ========================'
fishes = []
20.times do |n|
  time = Time.current
  fishes <<
    {
      fishing_date: Faker::Date.between(from: '2000-01-01', to: '2023-03-01'),
      body: Faker::Name.unique.name,
      latitude: Faker::Address.latitude.round(8),
      longitude: Faker::Address.longitude.round(8),
      species_id: rand(1..SPECIES_NUMBER),
      wether: 1,
      wind_direction: 1,
      wind_speed: 1,
      temperature: rand(0.0..40.0).round(2),
      tide_name: 1,
    }
end
Fish.insert_all! fishes, returning: nil
