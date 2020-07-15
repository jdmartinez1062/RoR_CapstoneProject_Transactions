class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new(user_params)
    if @user.save

      log_in(user)
      flash[:success] = 'You have signed up successfully!'
      redirect_to @user
    else
      flash.now[:warnign] = 'There was a problem'
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
