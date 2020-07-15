class SessionsController < ApplicationController
  include SessionsHelper
  def new; end

  def create
    if (user = User.find_by(name: params[:session][:name]))
      log_in(user)
      flash[:success] = 'You have logged in!'
      redirect_to user
    else
      flash.now[:warnign] = 'Log in unsuccessful'
      render 'new'
    end
  end

  def destroy
    flash[:success] = 'you have loggoed out successfully'
    log_out
  end
end
