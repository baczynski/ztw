class TournamentsController < ApplicationController
  before_filter :authorize_admin, only: [:new, :create]
  before_filter :authenticate_player!, only: [:register, :unregister, :details]

  def index
    @mode = (params[:mode] || :upcoming).to_sym
    @mode = :upcoming unless @mode.in? [:upcoming, :started, :finished]
    @tournaments = Tournament.try(@mode).order(start_date: :desc).page(params[:page])
  end

  def new
    @tournament = Tournament.new
  end

  def create
    rule_params = params[:tournament].delete(:rule_params)
    @tournament = Tournament.new(tournament_params)
    @tournament.build_rule rule_params
    if @tournament.save
      redirect_to root_path, notice: I18n.t('notice.tournament_created')
    else
      render :new
    end
  end

  def register
    tournament = Tournament.find(params[:id])
    if current_player.admin? || !tournament.check_rule_for(current_player)
      redirect_to root_path, flash: {error: I18n.t('notice.registration_denied')}
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
    @round = params[:round].try(:to_i) || @tournament[:round]
    @round -= 1 if @round > @tournament[:rounds]
    @matches = Match.round(params[:id], @round)
  end

  def edit_match
    @match = Match.match(params[:id]);
    res = params[:winner].eql?('NO-RESULT') ? nil : params[:winner]
    m = params[:id]
    @match.result = res
    @match.save
    respond_to do |format|
      format.json { render json: {result: res,match_id: m}}
    end
  end

  def next_round
    t = Tournament.find(params[:id])

    respond_to do |format|
      format.json { render json: {correct: t.next_round!} }
    end
  end

  def players
    @players = Tournament.find(params[:id]).players
  end

  def results

    @tournament = Tournament.find(params[:id])
    @matches= @tournament.matches
    @players= @tournament.players

  end

  private
  def tournament_params
    params.require(:tournament).permit(:name, :description, :start_date, :tournament_type, :rounds,
                                      :rule_type)
  end
end
