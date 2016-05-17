class ActivityRule < ActiveRecord::Base
  include Rule

  validates :games_limit, presence: true, numericality: {only_integer: true, larger_than: 0}

  class << self
    def rule_name_en
      "Activity rule"
    end

    def rule_name_pl
      "Aktywność w turniejach"
    end
  end

  def desc_pl
    "musisz wziąć udział przynajmniej w #{games_limit} turniejach"
  end

  def desc_en
    "you have to participate in at least #{games_limit} tournaments"
  end

  def permitted_params
    :games_limit
  end

  def is_satisfied_by?(player)
    player.tournaments_count >= games_limit
  end
end
