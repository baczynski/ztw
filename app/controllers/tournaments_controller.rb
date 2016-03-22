class TournamentsController < ApplicationController
  def index
  	@tournaments = Tournament.order start_date: :desc
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      redirect_to root_path, notice: 'Turniej został pomyślnie utworzony'
    else
      render :new
    end
  end

private
  def tournament_params
    params.require(:tournament).permit(:name, :description, :start_date, :tournament_type, :rounds)
  end
end