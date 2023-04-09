class MypageController < ApplicationController
  def dashboard
    @fishes = current_user.fishes.includes(:species).page(params[:page])
  end

  def follows
    @users = current_user.followings.order(follows: :desc).page(params[:page])
  end

  def followers
    @users = current_user.followers.order(follows: :desc).page(params[:page])
  end

  def notifications
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
    @notifications = @notifications.where.not(visitor_id: current_user.id)
  end
end
