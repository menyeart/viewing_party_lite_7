class DashboardController < ApplicationController
  def index
    if current_user == nil
      flash[:error] = "You must be logged in to visit the dashboard"
      redirect_to root_path
    end
  end


end