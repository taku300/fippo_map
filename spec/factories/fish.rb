FactoryBot.define do
  factory :fish do
    user { association :user }
    fishing_date { '2020/10/01' }
    body { 'body_1' }
    latitude { 36.15 }
    longitude { 140.15 }
    species { association :species }
    weather { 1 }
    wind_direction { 1 }
    wind_speed { 10.5 }
    temperature { 24.5 }
    tide_name { 1 }
  end
end
