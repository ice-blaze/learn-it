class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  COMMENTS_PER_PAGE = 2
  TUTORIALS_PER_PAGE = 2
  USER_DATA_PER_PAGE = 2
  USER_MANAGEMENT_PER_PAGE = 2

  def admin?
    current_user.try(:admin?)
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end
end
