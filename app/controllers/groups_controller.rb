class GroupsController < ApplicationController
  include SessionsHelper
  def index
    @groups = Group.all.paginate(page: params[:page])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.selected = current_user
    if @group.save
      flash[:success] = "New group #{@group.name} create successfully"
      redirect_to @group
    else
      flash[:warnign] = "New group couldn't be created"
      render 'new'
    end
  end

  def show
    @group = Group.find_by(id: params[:id])
  end

  def group_times
    Group.find_by(id: params[:id])
    @time_spents = time_spents.all.paginate(page: params[:page])
    @total = @time_spents.total
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
