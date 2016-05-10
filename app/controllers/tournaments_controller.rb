class TournamentsController < ApplicationController
  before_filter :authorize_admin, only: [:new, :create]
  before_filter :authenticate_player!, only: [:register, :unregister,:details]

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

  def details
    @tournament= Tournament.find(params[:id])
    @matches = Match.round(params[:id],@tournament[:round])
  end

  def edit_match
    @match = Match.match(params[:id]);
    if params[:winner].eql?('NO-RESULT')
      @match.result = nil
      @match.save
    else
      @match.result = params[:winner]
      @match.save
    end
  end

  def next_round
    matches = Match.round(params[:tournament_id],params[:round])
    found_nil = false
    matches.each do |t|
      if t[:result].nil?
        found_nil = true
      end
    end

=begin
    tournament_matches= Tournament.find(params[:tournament_id]).matches
    players_with_opponent = Array.new
    matches_in_tournament =
    matches_array = Array.new
    if found_nil
      @found_without_result=true
    else
      @found_without_result=false
      t = Tournament.find(params[:tournament_id])
      players_number = t.players.count
      for i in 0:players_number/2
        matches_array
      end
    end
=end

  end


private
  def tournament_params
    params.require(:tournament).permit(:name, :description, :start_date, :tournament_type, :rounds)
  end
end
