class UsersController < ApplicationController
  def show
    if current_admin?
      @user = User.find(current_user.id)
      redirect_to admin_dashboard_path
    elsif current_user == nil
      flash[:error] = "You must be logged in to visit the dashboard"
      redirect_to root_path
    else
      @user = User.find(current_user.id)
    end
  end

  def new
    @new_user = User.new
  end

  def create
    @new_user = User.new(user_attributes)
    if params[:password] != params[:password_confirmation] 
      redirect_to "/register"
      flash[:error] = "Passwords do not match"
    elsif @new_user.save
      session[:user_id] = @new_user.id
      redirect_to "/dashboard"
    else
      redirect_to "/register"
      flash[:error] = error_message(@new_user.errors)
    end
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to dashboard_path
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  def logout_user
    session[:user_id] = nil
    flash[:success] = "You've been successfully logged out!"
    redirect_to root_path
  end

  private

  def user_attributes
    params.permit(:name, :email, :password)
  end
end
