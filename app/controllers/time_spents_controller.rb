class TimeSpentsController < ApplicationController
  include SessionsHelper
  before_action :require_login, only: %i[create new]

  def new
    @time_spent = TimeSpent.new
  end

  def create
    if group_presence
      flash[:success] = 'Time spent logged successfully'
      redirect_to user_path(current_user)
    else
      flash.now[:warnign] = 'There was a problem'
      render 'new'
    end
  end

  private

  def time_params
    params.require(:time_spent).permit(:name, :amount)
  end

  def group_params
    params.require(:time_spent).permit(:groups)
  end

  def group_presence
    @time_spent = if (group = find_group)
                    group.time_spents.build(time_params.merge(author_id: current_user.id))

                  else
                    current_user.time_spents.build(time_params)
                  end
    @time_spent.save
  end

  def find_group
    Group.find_by(id: group_params[:groups])
  end
end
