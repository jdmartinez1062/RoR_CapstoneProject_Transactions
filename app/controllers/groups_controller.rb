class GroupsController < ApplicationController
  def index
    @groups = Groups.all.paginate(page: params[:page])
end

  def new
    @group = Group.new
  end

  def create; end

  def show
    @group = Group.find_by(id: params(:id))
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
