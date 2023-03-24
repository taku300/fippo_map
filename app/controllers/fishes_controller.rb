class FishesController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    @fishes = Fish.includes(:species)
  end

  def new; end

  def edit; end

  def show; end
end
