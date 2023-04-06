class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[show new create]
  before_action :set_user, only: %i[show edit update destroy]

  def show
    authorize(@user)

    @fishes = @user.fishes.includes(:species).order(fishing_date: :desc).page(params[:page])
  end

  def new
    authorize(User)

    @user = User.new
  end

  def edit
    authorize(@user)
  end

  def create
    authorize(User)

    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to fishes_path, notice: t('defaults.message.created', item: User.model_name.human)
    else
      flash.now[:alert] = t('defaults.message.not_created', item: User.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize(@user)

    if @user.update(user_params)
      redirect_to mypage_dashboard_path, notice: t('defaults.message.updated', item: User.model_name.human)
    else
      flash.now[:alert] = t('defaults.message.not_updated', item: User.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    redirect_to login_path, notice: t('defaults.message.deleted', item: User.model_name.human)
  end

  def add_published
    current_user.update!(is_published: true)
    redirect_to request.referer
  end

  def remove_published
    current_user.update!(is_published: false)
    redirect_to request.referer
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :avatar_cache, :introduction, :is_published)
  end
end
