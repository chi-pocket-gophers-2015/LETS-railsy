class SessionsController < ApplicationController

  def new
  end

  def create
    if @user = User.find_by(email: params[:session][:email])
      @user.authenticate(params[:session][:password_digest])
      session[:user_id] = @user.id
      redirect_to user_decisions_path(session[:user_id])
    else

      render(:new)
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end
end
