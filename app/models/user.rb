class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :fishes, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_fishes, through: :likes, source: :fish
  has_many :follows, class_name: "Follow", foreign_key: "follow_id", dependent: :destroy, inverse_of: 'follow'
  has_many :reverse_of_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy, inverse_of: 'follower'
  has_many :followings, through: :follows, source: :follower
  has_many :followers, through: :reverse_of_follows, source: :follow
  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, uniqueness: true, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :introduction, length: { maximum: 255 }, allow_blank: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

  def own?(object)
    id == object.user_id
  end

  def like(fish)
    like_fishes << fish
  end

  def unlike(fish)
    like_fishes.destroy(fish)
  end

  def like?(fish)
    like_fishes.include?(fish)
  end

  def follow(user_id)
    follows.create(follower_id: user_id)
  end

  def unfollow(user_id)
    follows.find_by(follower_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
end
