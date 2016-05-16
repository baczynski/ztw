class TournamentsController < ApplicationController
  before_filter :authorize_admin, only: [:new, :create]
  before_filter :authenticate_player!, only: [:register, :unregister, :details]

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
    @round = @tournament[:round]
    if params[:round].present?
      @round = params[:round]
    end
    if @round.to_i > @tournament[:rounds]
      @round= @round.to_i() -1
    end
    if params[:next_round].present? && @round.to_i < @tournament[:round]
      if @round.to_i <@tournament[:rounds]
        @round = (@round.to_i() +1)
      end
    elsif params[:previous_round].present?
      if @round.to_i >1
        @round = (@round.to_i() -1)
      end
    end
    @matches = Match.round(params[:id], @round)
  end

  def edit_match
    @match = Match.match(params[:id]);
    res = params[:winner].eql?('NO-RESULT') ? nil : params[:winner]
    @match.result = res
    @match.save
    respond_to do |format|
      format.json { render json: {result: res} }
    end
  end

  def next_round
    t = Tournament.find(params[:id])
    matches = Match.round(params[:id], t[:round])
    found_nil = false
    matches.each do |t|
      if t[:result].nil?
        found_nil = true
      end
    end
    respond_to do |format|
      format.json { render json: {res1: found_nil} }
    end

    unless found_nil


      t[:round] = t[:round] + 1
      t.save
      if t[:round] <= t[:rounds]
        tournament_players = Tournament.find(params[:id]).players
        players_with_opponent= Array.new
        players_number = t.players.count
        for i in 0..((players_number/2)-1)
          p1 = rand(0...players_number)
          while players_with_opponent.include?(p1) do
            p1 = rand(0...players_number)
          end
          players_with_opponent.append p1
          p2 = rand(0...players_number)
          while players_with_opponent.include?(p2) do
            p2 = rand(0...players_number)
          end

          players_with_opponent.append p2
          m = Match.new(white_player_id: tournament_players[p1][:id], black_player_id: tournament_players[p2][:id], round: t[:round], tournament_id: t[:id])
          m.save

        end
      end

    end

  end


  private
  def tournament_params
    params.require(:tournament).permit(:name, :description, :start_date, :tournament_type, :rounds)
  end
end
