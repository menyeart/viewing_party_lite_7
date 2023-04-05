class ApplicationController < ActionController::Base
  helper_method :current_user
  add_flash_types :error, :success

  def current_user
    @_current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # def authorization
  #   if current_user.nil? 
  #     flash[:error] = "You must be logged in or registered to continue."
  #     redirect_to root_path
  #   else
  #     @user = User.find(params[:id])
  #     @user ||= current_user
  #   end
  # end

  private
  def error_message(errors)
    errors.full_messages.join(", ")
  end
end
