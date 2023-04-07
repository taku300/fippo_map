class MypageController < ApplicationController
  def dashboard
    @fishes = current_user.fishes.includes(:species).order(fishing_date: :desc).page(params[:page])
  end

  def follows
    @users = current_user.followings.order(follows: :desc).page(params[:page])
  end

  def followers
    @users = current_user.followers.order(follows: :desc).page(params[:page])
  end
end
