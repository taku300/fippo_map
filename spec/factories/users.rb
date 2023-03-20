FactoryBot.define do
  factory :user do
    sequence(:name, "name_1")
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    introduction { 'introduction_1' }
    is_published { true }
  end

  trait :secret do
    is_published { false }
  end
end
