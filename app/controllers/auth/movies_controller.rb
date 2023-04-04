class Auth::MoviesController < ApplicationController
  def show
    @movie = MoviesFacade.new(params[:id])
  end

end