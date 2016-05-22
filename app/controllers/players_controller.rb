class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:id])
  end
  def players_tournaments
    @tournaments = Player.find(params[:id]).tournaments
  end
end
