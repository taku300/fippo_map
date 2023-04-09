class FishesController < ApplicationController
  include FishHelper
  skip_before_action :verify_authenticity_token
  skip_before_action :require_login, only: %i[index list show]
  before_action :set_fish, only: %i[show edit update destroy]

  def index
    authorize(Fish)

    @q = Fish.ransack(params[:q])
    @fishes = @q.result(distinct: true).includes(:species, :user)
    if logged_in?
      @fishes = @fishes.published.or(@fishes.where(user_id: current_user.id))
    else
      @fishes = @fishes.published
    end
  end

  def list
    authorize(Fish)

    @fishes = Fish.includes(:species, :user).page(params[:page]).per(20)
    if logged_in?
      @fishes = @fishes.published.or(@fishes.where(user_id: current_user.id))
    else
      @fishes = @fishes.published
    end
  end

  def show
    authorize(@fish)

    @user = @fish.user
    @comment = Comment.new
    @comments = @fish.comments.includes(:user).order(created_at: :asc)
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
    authorize(Fish)

    Fish.transaction do
      species = create_or_find_species
      @fish = current_user.fishes.new(fish_params)
      @fish.species_id = species.id
      @fish.save!
      current_user.update!(grade: current_user.grade_calc)
      session[:latitude] = params[:fish][:latitude]
      session[:longitude] = params[:fish][:longitude]
      session[:fish_id] = @fish.id
      redirect_to complete_fishes_path, notice: t('defaults.message.created', item: Fish.model_name.human)
    rescue ActiveRecord::RecordInvalid => exception
      flash.now[:alert] = t('defaults.message.not_created', item: Fish.model_name.human)
      render action: :new, status: :unprocessable_entity
    end
  end

  def update
    authorize(@fish)

    Fish.transaction do
      species = create_or_find_species
      @fish.assign_attributes(fish_params)
      @fish.species_id = species.id
      @fish.save!
      session[:latitude] = params[:fish][:latitude]
      session[:longitude] = params[:fish][:longitude]
      session[:fish_id] = @fish.id
      redirect_to complete_edit_fishes_path, notice: t('defaults.message.updated', item: Fish.model_name.human)
    rescue ActiveRecord::RecordInvalid => exception
      flash.now[:alert] = t('defaults.message.not_updated', item: Fish.model_name.human)
      render action: :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize(@fish)

    Fish.transaction do
      @fish.destroy!
      current_user.update!(grade: current_user.grade_calc)
      redirect_to fishes_path, notice: t('defaults.message.deleted', item: Fish.model_name.human)
    end
  end

  def complete
    fish_id = session[:fish_id]
    @fish = Fish.find(fish_id)
  end

  def complete_edit
    fish_id = session[:fish_id]
    @fish = Fish.find(fish_id)
  end

  # ajaxで現在の気象情報を取得するためのメソッド
  def ajax_current_weather
    date = Time.current
    latitude = session[:latitude]
    longitude = session[:longitude]
    response = weather_current_request(latitude, longitude)
    respond_to do |format|
      format.json { render json: input_current_default(date, latitude, longitude, response) }
    end
  end

  def ajax_history_weather
    date = params[:date]
    latitude = params[:latitude]
    longitude = params[:longitude]
    response = weather_history_request(date, latitude, longitude)
    respond_to do |format|
      format.json { render json: input_history_default(date.to_time, latitude, longitude, response) }
    end
  end

  private

  def create_or_find_species
    if Species.exists?(name: species_params[:species])
      Species.find_by(name: species_params[:species])
    else
      Species.create!(name: species_params[:species])
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
