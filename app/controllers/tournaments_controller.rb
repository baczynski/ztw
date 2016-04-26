class TournamentsController < ApplicationController
  before_filter :authorize_admin, only: [:new, :create]
  before_filter :authenticate_player!, only: [:register, :unregister]

  def index
    @mode = (params[:mode] || :upcoming).to_sym
    if @mode == :upcoming
      @tournaments = Tournament.upcoming.order(start_date: :asc)
    else
      @tournaments = Tournament.finished.order(start_date: :desc)
    end
    @tournaments = @tournaments.page(params[:page])
  end

  def new
    @tournament = Tournament.new
    @tournament.address.build
  end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      redirect_to root_path, notice: I18n.t('notice.tournament_created')
    else
      render :new
    end
  end

  def register
    tournament = Tournament.find(params[:id])
    if current_player.admin?
      redirect_to root_path, notice: I18n.t('notice.registration_denied')
    else
      tournament.players << current_player
      redirect_to root_path, notice: I18n.t('notice.registered')
    end
  end

  def unregister
    tournament = Tournament.find(params[:id])
    tournament.players.delete(current_player)
    redirect_to root_path, notice: I18n.t('notice.unregistered')
  end

private
  def tournament_params
    params.require(:tournament).permit(:name, :description, :start_date, :tournament_type, :rounds)
  end
end
