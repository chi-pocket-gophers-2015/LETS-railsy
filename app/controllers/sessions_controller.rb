class SessionsController < ApplicationController

  def new
  end

  def create
    puts params
    if @user = User.find_by(email: params[:session][:email])
      @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else

      render(:new)
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end
end
