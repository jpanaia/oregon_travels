class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  # around_filter :with_timezone

  # private

  # def with_timezone
  #   timezone = Time.find_zone(cookies[:timezone])
  #   Time.use_zone(timezone) { yield }
  # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit({ roles: [] }, :email, :password, 
    :password_confirmation, :username, :avatar) }

   devise_parameter_sanitizer.for(:account_update) { |u| u.permit({ roles: [] }, :email, :password, 
   :password_confirmation, :current_password, :username, :avatar) }
  end
  
end
