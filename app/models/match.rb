class Match < ActiveRecord::Base
  RESULT = ['WHITE','BLACK','DRAW']
  belongs_to :white_player, class_name: 'Player', foreign_key: 'white_player_id'
  belongs_to :black_player, class_name: 'Player', foreign_key: 'black_player_id'


  belongs_to :tournament
end
