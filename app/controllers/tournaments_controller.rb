class TournamentsController < ApplicationController
  before_filter :authorize_admin, only: [:new, :create]
  before_filter :authenticate_player!, only: [:register, :unregister]

  def index
  	@tournaments = Tournament.order(start_date: :desc).paginate(page: params[:page])
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

  def register
    tournament = Tournament.find(params[:id])
    if current_player.admin?
      redirect_to root_path, notice: 'Nie możesz zarejestrować się na turniej!'
    else
      tournament.players << current_player
      redirect_to root_path, notice: 'Zostałeś zarejestrowany na turniej'
    end
  end

  def unregister
    tournament = Tournament.find(params[:id])
    tournament.players.delete(current_player)
    redirect_to root_path, notice: 'Zostałeś wyrejestrowany z turnieju'
  end

private
  def tournament_params
    params.require(:tournament).permit(:name, :description, :start_date, :tournament_type, :rounds)
  end
end
