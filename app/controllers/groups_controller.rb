class GroupsController < ApplicationController
  include SessionsHelper
  include ApplicationHelper
  before_action :require_login, only: %i[create new]
  before_action :set_page, only: %i[index group_times]
  before_action :set_id, only: %i[show group_times]

  def index
    @groups = Group.all.paginate(page: @page)
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
    @group = Group.find_by(id: @id)
  end

  def group_times
    @group = Group.find_by(id: @id)
    @time_spents = @group.group_spents.paginate(page: @page)
    @total = @time_spents.total
    render 'time_spents/index'
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
