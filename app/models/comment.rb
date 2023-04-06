class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :fish

  validates :body, presence: true, length: { maximum: 255 }
end
