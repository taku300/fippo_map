class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path, notice: t('defaults.message.created', item: User.model_name.human)
    else
      flash.now[:alert] = t('defaults.message.not_created', item: User.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def update; end

  def add_published
    current_user.update!(is_published: true)
    redirect_to mypage_dashboard_path
  end

  def remove_published
    current_user.update!(is_published: false)
    redirect_to mypage_dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :avatar_cache, :introduction, :is_published)
  end
end
