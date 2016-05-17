class RatingRule < ActiveRecord::Base
  include Rule

  validates :min_rating, presence: true, numericality: {only_integer: true}

  class << self
    def rule_name_en
      "Rating rule"
    end

    def rule_name_pl
      "Minimalny dozwolony ranking"
    end
  end

  def desc_pl
    "musisz mieć ranking przynajmniej #{min_rating}"
  end

  def desc_en
    "ranking #{min_rating} is required"
  end

  def permitted_params
    :min_rating
  end

  def is_satisfied_by?(player)
    player.rating >= min_rating
  end
end
