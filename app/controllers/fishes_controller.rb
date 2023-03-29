class FishesController < ApplicationController
  include FishHelper
  skip_before_action :require_login, only: %i[index show]
  before_action :set_fish, only: %i[show edit update destroy]

  def index
    authorize(Fish)

    @fishes = Fish.includes(:species)
  end

  def show
    authorize(@fish)

    @user = @fish.user
  end

  def new
    authorize(Fish)

    session[:latitude] = params[:latitude]
    session[:longitude] = params[:longitude]
    @fish = Fish.new
  end

  def edit
    authorize(@fish)
  end

  def create
    authorize(@fish)

    Fish.transaction do
      if Species.exists?(name: species_params[:species])
        species = Species.find_by(name: species_params[:species])
      else
        species = Species.create!(name: species_params[:species])
      end
      @fish = current_user.fishes.new(fish_params)
      @fish.species_id = species.id
      @fish.save!
      redirect_to complete_fishes_path, notice: t('defaults.message.created', item: Fish.model_name.human)
    rescue ActiveRecord::RecordInvalid => exception
      flash.now[:alert] = t('defaults.message.not_created', item: Fish.model_name.human)
      render action: :new, status: :unprocessable_entity
    end
  end

  def update
    authorize(@fish)

    Fish.transaction do
      if Species.exists?(name: species_params[:species])
        species = Species.find_by(name: species_params[:species])
      else
        species = Species.create!(name: species_params[:species])
      end
      @fish.assign_attributes(fish_params)
      @fish.species_id = species.id
      @fish.save!
      redirect_to complete_edit_fishes_path, notice: t('defaults.message.updated', item: Fish.model_name.human)
    rescue ActiveRecord::RecordInvalid => exception
      flash.now[:alert] = t('defaults.message.not_updated', item: Fish.model_name.human)
      render action: :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize(@fish)

    @fish.destroy!
    redirect_to fishes_path, notice: t('defaults.message.deleted', item: Fish.model_name.human)
  end

  def complete; end

  def complete_edit; end

  # ajaxで現在の気象情報を取得するためのメソッド
  def ajax_current_weather
    date = Time.current
    latitude = session[:latitude]
    longitude = session[:longitude]
    respond_to do |format|
      format.json { render json: imput_default(date, latitude, longitude) }
    end
  end

  def fish_params
    params.require(:fish).permit(:image, :image_cache, :fishing_date, :body, :species_id, :size, :latitude, :longitude, :weather, :wind_direction, :wind_speed, :temperature, :tide_name)
  end

  def species_params
    params.require(:fish).permit(:species)
  end

  def set_fish
    @fish = Fish.find(params[:id])
    session[:latitude] = @fish.latitude
    session[:longitude] = @fish.longitude
  end
end
