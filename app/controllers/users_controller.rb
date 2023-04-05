class UsersController < ApplicationController
  def show
    if current_user
     @user = User.find(params[:id])
    else
      flash[:error] = "You must be logged in to access your dashboard."
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def create
    user = user_attributes
    user[:email] = user[:email].downcase
    new_user = User.create(user)
    session[:user_id] = new_user.id
    if new_user.save
      redirect_to "/users/#{new_user.id}"
    else
      redirect_to "/register"
      flash[:error] = error_message(new_user.errors)
    end
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user)
    else
      flash[:error] = "Sorry your credentials are bad."
      render :login_form
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_attributes
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
