class ViewingPartyController < ApplicationController
  def new
    if current_user.nil?
      flash[:error] = "You must be logged in or register to continue."
      redirect_to user_movie_path(params[:user_id], params[:movie_id])
    else
      @user = current_user
      @movie = MoviesFacade.new(params[:movie_id])
      @users = User.all
    end
  end

  def create
    @user = current_user
    @movie = MoviesFacade.new(params[:movie_id])
    @new_party = ViewingParty.new(party_attributes)
    if @new_party.save
      # params["email"].each do |email|
      #   ViewingPartyUser.create!(user_id: User.where("users.email = '#{email.to_s.gsub("{:value=>", "").tr!("\"","").tr!("}","")}'").id, viewing_party_id: @new_party.id)
      # end
      redirect_to user_path(@user)
    else
      redirect_to new_user_movie_viewing_party_path(@user, @movie.detailed_movie.movie_id_show)
      flash[:error] = error_message(@new_party.errors)
    end
  end

  private

  def party_attributes
    params.permit(:duration, :start_time, :date, :movie_id, :host_id)
  end
end
