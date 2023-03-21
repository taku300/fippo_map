class UserSessionsController < ApplicationController
  skip_before_action :require_login

  # 簡易ログインん機能、開発環境のみ有効
  def login_as
    user = User.find(params[:user_id])
    auto_login(user)
    redirect_to root_path, notice: "#{Rails.env}環境でログインしました"
  end

  def new; end

  def create
    @user = login(params[:user][:email], params[:user][:password])
    if @user
      redirect_back_or_to root_path, notice: t('.login')
    else
      flash.now[:alert] = t('.not_login')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: t('user_sessions.destroy.logout')
  end
end
