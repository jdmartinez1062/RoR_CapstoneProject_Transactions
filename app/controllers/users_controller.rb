class UsersController < ApplicationController
  include SessionsHelper
  before_action :require_login, only: %i[show]
  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])
  end

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
    @time_spents = current_user.group_time_spents.paginate(page: params[:page])
    @total = @time_spents.calculate(:sum, :amount)
    render 'time_spents/index'
  end

  def external_times
    @time_spents = current_user.external_time_spents.paginate(page: params[:page])
    @total = @time_spents.total
    render 'time_spents/index'
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
