class Match < ActiveRecord::Base
  RESULT = ['WHITE','BLACK','DRAW']
  RATING_BOUNDS = [3, 10, 17, 25, 32, 39, 46, 53, 61, 68, 76, 83, 91, 98, 106, 113, 121, 137, 145, 153, 162, 170, 179, 188, 197, 206, 215, 225, 235, 236, 245, 256, 267, 278, 290, 302, 315, 328, 344, 357, 374, 391, 411, 432, 456, 484, 517, 559, 619, 735]

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

  def score_for_white
    if result
      case result
        when 'WHITE' then 1
        when 'DRAW' then 0.5
        when 'BLACK' then 0
      end
    end
  end

  def score_for_black
    if result
      case result
        when 'BLACK' then 1
        when 'DRAW' then 0.5
        when 'WHITE' then 0
      end
    end
  end

  def update_result!
    diff = (white_player.rating - black_player.rating).abs
    cent = RATING_BOUNDS.find_index {|x| x >= diff}
    cent *= -1 if white_player.rating < black_player.rating

    white_pd = score_for_white - (50 - cent) / 100.0
    black_pd = score_for_black - (50 + cent) / 100.0

    self.white_rating_change = (white_pd * white_player.coef).round
    self.black_rating_change = (black_pd * black_player.coef).round

    self.white_rating_before = white_player.rating
    self.black_rating_before = black_player.rating

    white_player.increment! :rating, white_rating_change
    black_player.increment! :rating, black_rating_change

    save
  end
end
