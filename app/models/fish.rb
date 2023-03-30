class Fish < ApplicationRecord
  belongs_to :user
  belongs_to :species
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  mount_uploader :image, FishImageUploader

  enum weather: { fine: 0, sunny: 1, cloudy: 2, fog: 3, drizzle: 4, rain: 5, snow: 6, thunderstorm: 7 }
  enum wind_direction: { north: 0, north_northeast: 1, northeast: 2, east_northeast: 3, east: 4, east_southeast: 5, southeast: 6, south_southeast: 7, south: 8, south_southwest: 9, southwest: 10, west_southwest: 11, west: 12, west_northwest: 13, northwest: 14, north_northwest: 15 }
  enum tide_name: { spring: 0, middle: 1, neap: 2, long: 3, wakashio: 4 }

  validates :fishing_date, presence: true,
            date: {
              # 1900年1月1日より後で現在の日付までの範囲のみ許可する
              after: Date.new(1900, 1, 1),
              before: ->(obj) { Time.zone.now }
            }
  validates :body, presence: true, length: { maximum: 255 }
  validates :latitude, presence: true, numericality: { in: -90..90, message: 'は-90~90で入力してください' }
  validates :longitude, presence: true, numericality: { in: -180..180, message: 'は-180~180で入力してください' }
  validates :size, numericality: { only_integer: true }, allow_blank: true
  validates :weather, presence: true
  validates :wind_direction, presence: true
  validates :wind_speed, presence: true, numericality: true
  validates :temperature, presence: true, numericality: true
  validates :tide_name, presence: true

  def latest?
    Date.parse(fishing_date.to_s) == Time.zone.today
  end

  def species_default
    species_id ? species.name : ''
  end

  def self.ransackable_associations(auth_object = nil)
    ["likes", "species", "user", "users"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "fishing_date", "id", "user_id", "image", "latitude", "longitude", "size", "species_id", "temperature", "tide_name", "updated_at", "user_id", "weather", "wind_direction", "wind_speed"]
  end
end
