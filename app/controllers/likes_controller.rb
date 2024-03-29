class LikesController < ApplicationController
  def create
    @fish = Fish.find(params[:fish_id])
    current_user.like(@fish)
    @fish.create_notification_like!(current_user)
    redirect_to request.referer
  end

  def destroy
    @fish = current_user.likes.find(params[:id]).fish
    current_user.unlike(@fish)
    redirect_to request.referer
  end
end
