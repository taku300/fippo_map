class Fish < ApplicationRecord
  default_scope -> { order(fishing_date: :desc) }
  belongs_to :user
  belongs_to :species
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
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

  scope :published, -> { where(user: { is_published: true }) }

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

  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and fish_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        fish_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(fish_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      fish_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
