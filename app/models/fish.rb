class Fish < ApplicationRecord
  belongs_to :species

  enum wether: { fine: 0, sunny: 1, partly_cloudy: 2, cloudy: 3, fog: 4, drizzle: 5, rain_ice: 6, rain: 7, snow: 8, thunderstorm: 9, hail: 10 }
  enum wind_direction: { north: 0, north_northeast: 1, northeast: 2, east_northeast: 3, east: 4, east_southeast: 5, southeast: 6, south_southeast: 7, south: 8, south_southwest: 9, southwest: 10, west_southwest: 11, west: 12, west_northwest: 13, northwest: 14, north_northwest: 15 }
  enum tide_name: { spring: 0, middle: 1, neap: 2, long: 3, wakashio: 4 }

  validates :fishing_date, presence: true,
            date: {
              # 1900年1月1日より後で現在の日付までの範囲のみ許可する
              after: Date.new(1900, 1, 1),
              before: ->(obj) { Time.zone.today }
            }
  validates :body, presence: true, length: { maximum: 255 }
  validates :latitude, presence: true, numericality: true, format: { with: /\A([0-9]{0,3}|0)(.[0-9]{0,8})?\z/, message: 'は整数部分3桁小数部分8桁で入力してください' }
  validates :longitude, presence: true, numericality: true, format: { with: /\A([0-9]{0,3}|0)(.[0-9]{0,8})?\z/, message: 'は整数部分3桁小数部分8桁で入力してください' }
  validates :size, numericality: { only_integer: true }
  validates :wether, presence: true, numericality: { only_integer: true }
  validates :wind_direction, presence: true, numericality: { only_integer: true }
  validates :wind_speed, presence: true, numericality: true, format: { with: /\A([0-9]{0,3}|0)(.[0-9]{0,2})?\z/, message: 'は整数部分3桁小数部分2桁で入力してください' }
  validates :temperature, presence: true, numericality: true, format: { with: /\A([0-9]{0,3}|0)(.[0-9]{0,2})?\z/, message: 'は整数部分3桁小数部分2桁で入力してください' }
  validates :tide_name, presence: true, numericality: { only_integer: true }
end
