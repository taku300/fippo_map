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

  before_create -> { self.uuid = 'fippo-' + SecureRandom.hex(10) }

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

  def self.ransackable_attributes(auth_object = nil)
    ["access_count_to_reset_password_page", "avatar", "created_at", "crypted_password", "email", "id", "introduction", "is_published", "name", "reset_password_email_sent_at", "reset_password_token", "reset_password_token_expires_at", "salt", "updated_at"]
  end

  def grade_calc
    level1 = 1
    level2 = 3
    level3 = 8
    level4 = 15
    level5 = 30
    num = fishes.count
    case num
    when level1..(level2 - 1)
      1
    when level2..(level3 - 1)
      2
    when level3..(level4 - 1)
      3
    when level4..(level5 - 1)
      4
    else
      5
    end
  end
end
