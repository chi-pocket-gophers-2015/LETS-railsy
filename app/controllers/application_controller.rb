class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :check_for_login

  def check_for_login
    unless logged_in?
      redirect_to login_path
    end
  end

  def current_user
    @_current_user ||= User.find_by_id(session[:user_id])
  end

  helper_method :current_user

  def logged_in?
    !!current_user
  end

  helper_method :logged_in?

end
