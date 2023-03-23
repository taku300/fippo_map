class Fish < ApplicationRecord
  belongs_to :species

  enum wether: { draft: 0, published: 1, publish_wait: 2 }

  validates :fishing_date, presence: true,
            date: {
              # 1900年1月1日より後で現在の日付までの範囲のみ許可する
              after: Date.new(1900, 1, 1),
              before: ->(obj) { Date.today }
            }
  validates :body, presence: true, length: { maximum: 255 }
  validates :latitude, presence: true, numericality: true, format: { with: /\A([0-9]{0,3}|0)(.[0-9]{0,8})?\z/, message: 'は整数部分3桁小数部分8桁で入力してください' }
  validates :longitude, presence: true, numericality: true, format: { with: /\A([0-9]{0,3}|0)(.[0-9]{0,8})?\z/, message: 'は整数部分3桁小数部分8桁で入力してください' }
  validates :species, presence: true
  validates :size, numericality: { only_integer: true }
  validates :wether, presence: true, numericality: { only_integer: true }
  validates :wind_direction, presence: true, numericality: { only_integer: true }
  validates :wind_speed, presence: true, numericality: true, format: { with: /\A([0-9]{0,3}|0)(.[0-9]{0,2})?\z/, message: 'は整数部分3桁小数部分2桁で入力してください' }
  validates :temperature, presence: true, numericality: true, format: { with: /\A([0-9]{0,3}|0)(.[0-9]{0,2})?\z/, message: 'は整数部分3桁小数部分2桁で入力してください' }
  validates :tide_name, presence: true, numericality: { only_integer: true }
end
