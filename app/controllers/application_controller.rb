class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  COMMENTS_PER_PAGE = 2
  TUTORIALS_PER_PAGE = 2

  def admin?
    current_user.try(:admin?)
  end
end
