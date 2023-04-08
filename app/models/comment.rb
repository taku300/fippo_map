class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :fish
  has_many :notifications, dependent: :destroy

  validates :body, presence: true, length: { maximum: 255 }
end
