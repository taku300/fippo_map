class Species < ApplicationRecord
  has_many :fishes

  validates :name, presence: true, length: { maximum: 255 }
end
