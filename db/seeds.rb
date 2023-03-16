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
# POST_NUMBER = 10
# posts = []
# POST_NUMBER.times do |n|
#   time = Time.current
#   posts <<
#     {
#       name: Faker::Name.unique.name,
#     }
# end
# Post.insert_all! users, returning: nil
