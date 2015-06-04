class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    puts user_params
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to profile_path(@user)
    else
      flash.now[:error] = "Sign Up unsuccessful; please try again."
      render(:new)
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
