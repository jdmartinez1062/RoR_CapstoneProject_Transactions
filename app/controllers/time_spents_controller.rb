class TimeSpentsController < ApplicationController
  include SessionsHelper

  def new
    @time_spent = TimeSpent.new
  end

  def create; end

  private

  def time_params
    params.require(:time_spents).permit(:name, :amount)
  end
end
