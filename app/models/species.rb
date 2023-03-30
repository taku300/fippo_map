class Species < ApplicationRecord
  has_many :fishes, dependent: :nullify

  validates :name, presence: true, length: { maximum: 255 }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
end
