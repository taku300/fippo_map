class LikesController < ApplicationController
  def create
    authorize(Like)

    @fish = Fish.find(params[:fish_id])
    current_user.like(@fish)
    redirect_to fish_path(@fish)
  end

  def destroy
    authorize(Like)

    @fish = current_user.likes.find(params[:id]).fish
    current_user.unlike(@fish)
    redirect_to fish_path(@fish)
  end
end
