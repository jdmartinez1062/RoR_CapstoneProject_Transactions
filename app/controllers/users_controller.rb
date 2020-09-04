class UsersController < ApplicationController
  include SessionsHelper
  include ApplicationHelper
  before_action :require_login, only: %i[show]
  before_action :set_user, only: %i[show]
  before_action :set_page, only: %i[user_times external_times]
  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new(user_params)

    if @user.save

      log_out if logged_in?
      log_in(@user)
      flash[:success] = 'You have signed up successfully!'
      redirect_to @user
    else
      flash.now[:warnign] = 'There was a problem'
      render 'new'
    end
  end

  def user_times
    @time_spents = current_user.group_time_spents.paginate(page: @page)
    @total = @time_spents.calculate(:sum, :amount)
    render 'time_spents/index'
  end

  def external_times
    @time_spents = current_user.external_time_spents.paginate(page: @page)
    @total = @time_spents.total
    render 'time_spents/index'
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
