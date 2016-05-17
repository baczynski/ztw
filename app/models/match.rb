class Match < ActiveRecord::Base
  RESULT = ['WHITE','BLACK','DRAW']

  belongs_to :white_player, class_name: 'Player', foreign_key: 'white_player_id'
  belongs_to :black_player, class_name: 'Player', foreign_key: 'black_player_id'
  belongs_to :tournament

  def self.round(tournament,round)
    where(arel_table[:tournament_id].eq(tournament)).where(arel_table[:round].eq(round))
  end

  def self.match(match_id)
    find(match_id)
  end
  
  def ==(another_match)
    (self.white_player == another_match.white_player && self.black_player == another_match.black_player) ||  (self.white_player == another_match.black_player && self.black_player == another_match.white_player)
  end
end
