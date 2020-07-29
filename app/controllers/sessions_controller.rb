class SessionsController < ApplicationController
  include SessionsHelper
  def new
    redirect_to current_user if current_user
  end

  def create
    if (user = User.find_by(name: params[:session][:name]))
      log_in(user)
      flash[:success] = 'You have logged in!'
      redirect_to user
    else
      flash.now[:warnign] = 'Log in unsuccessful'
      render 'new', warnign: 'Log in unsuccessful'
    end
  end

  def destroy
    flash[:success] = 'you have logged out successfully'
    log_out
  end

  def require_login
    return unless current_user.nil?

    flash[:danger] = 'Please log in.'
    redirect_to login_url
  end
end
