class Admin::DashboardController < ApplicationController
  def show
    # Yeah, I know it should be a model method, sorry
    @users = User.where("users.id != ?", current_user.id)
  end

end