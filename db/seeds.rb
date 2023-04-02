# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
USER_NUMBER = 10
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
USER_NUMBER.times do |n|
  User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: "password",
    password_confirmation: "password",
    introduction: Faker::Lorem.paragraph,
    is_published: true,
  )
end

p '==================== species create ======================='
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

p '==================== today fishes create ==================='
fishes = []
10.times do |n|
  fishes <<
    {
      user_id: rand(1..USER_NUMBER),
      fishing_date: Time.current,
      body: Faker::Lorem.paragraph,
      latitude: rand(20.0..46.0).round(8),
      longitude: rand(122.0..154.0).round(8),
      species_id: rand(1..SPECIES_NUMBER),
      weather: Fish.weathers.values.sample,
      wind_direction: Fish.wind_directions.values.sample,
      wind_speed: rand(0.0..40.0).round(2),
      temperature: rand(0.0..40.0).round(2),
      tide_name: Fish.tide_names.values.sample,
    }
end
Fish.insert_all! fishes, returning: nil

p '==================== fishes create ========================='
fishes = []
100.times do |n|
  fishes <<
    {
      user_id: rand(1..USER_NUMBER),
      fishing_date: Faker::Date.between(from: '2000-01-01', to: '2023-03-01'),
      body: Faker::Lorem.paragraph,
      latitude: rand(20.0..46.0).round(8),
      longitude: rand(122.0..154.0).round(8),
      species_id: rand(1..SPECIES_NUMBER),
      weather: Fish.weathers.values.sample,
      wind_direction: Fish.wind_directions.values.sample,
      wind_speed: rand(0.0..40.0).round(2),
      temperature: rand(0.0..40.0).round(2),
      tide_name: Fish.tide_names.values.sample,
    }
end
Fish.insert_all! fishes, returning: nil
