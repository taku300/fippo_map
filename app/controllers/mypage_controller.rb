class MypageController < ApplicationController
  def dashboard; end

  # フォロー一覧
  # def follows
  #   user = User.find(params[:user_id])
  #   @users = user.followings
  # end
  # フォロワー一覧
  # def followers
  #   user = User.find(params[:user_id])
  #   @users = user.followers
  # end
end
