class TimeSpentsController < ApplicationController
  include SessionsHelper

  def new
    @time_spent = TimeSpent.new
  end

  def create
    @time_spent = group_presence

    if @time_spent.save
      flash[:success] = 'Time spent logged successfully'
      redirect_to group_times_path
    else
      flash.now[:warnign] = 'There was a problem'
      render 'new'
    end
  end

  private

  def time_params
    params.require(:time_spent).permit(:name, :amount)
  end

  def group_param
    params.require(:time_spent).permit(:group)
  end

  def group_presence
    if (group = Group.find_by(id: group_param[:group]))
      group.time_spents.build(time_params, author_id: current_user.id)
    else
      current_user.build(time_params)
    end
  end
end
