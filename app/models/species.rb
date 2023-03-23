class Species < ApplicationRecord
  has_many :fishes, dependent: :nullify

  validates :name, presence: true, length: { maximum: 255 }
end
