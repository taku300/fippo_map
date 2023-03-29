class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def not_authenticated
    redirect_to login_url, alert: t('defaults.message.require_login')
  end

  def user_not_authorized
    render file: Rails.public_path.join('403.html'), status: :forbidden
  end
end
