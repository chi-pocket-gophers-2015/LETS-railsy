class SessionsController < ApplicationController

  skip_before_action :check_for_login, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to profile_path
    else
      flash.now[:error] = "Log In unsuccessful; please try again."
      render(:new)
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end
end
