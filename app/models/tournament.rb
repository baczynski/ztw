class Tournament < ActiveRecord::Base
  TOURNAMENT_TYPE = {
    'ONSITE' => 'on-site',
    'ONLINE' => 'on-line'
  }

  RULE_TYPES = [ActivityRule, RatingRule]

  has_and_belongs_to_many :players
  has_many :matches
  belongs_to :rule, polymorphic: true

  accepts_nested_attributes_for :rule

  validates :name, :description, :start_date, :tournament_type, :rounds, presence: true
  validates :tournament_type, inclusion: {in: TOURNAMENT_TYPE.keys}
  validates :name, :start_date, uniqueness: {case_sensitive: false}
  validates :rounds, numericality: {only_integer: true, greater_than: 0}
  validates :start_date, date: {after: proc {Time.now} }, on: :create

  before_create :set_defaults
  after_create :delay_start

  self.per_page = 20

  def self.upcoming
    where(round: 0)
  end

  def self.started
    where(arel_table[:round].gt(0).and(arel_table[:round].lteq(arel_table[:rounds])))
  end

  def self.finished
    where(arel_table[:round].gt(arel_table[:rounds]))
  end

  def build_rule(params)
    self.rule = self.rule_type.constantize.new(params) if rule.present?
  end

  def check_rule_for(player)
    rule.blank? || rule.is_satisfied_by?(player)
  end

  def next_round!
    ms = matches.where(round: self.round)
    return false if ms.all.any? {|m| m.result.blank?}

    self.round += 1
    if round <= rounds
      players_with_opponent = []
      players_number = players.count
      (players_number/2).times do
        p1 = rand(0...players_number)
        while players_with_opponent.include?(p1) do
          p1 = rand(0...players_number)
        end
        players_with_opponent << p1

        p2 = rand(0...players_number)
        while players_with_opponent.include?(p2) do
          p2 = rand(0...players_number)
        end
        players_with_opponent << p2

        matches.create(
          white_player_id: players[p1].id,
          black_player_id: players[p2].id,
          round: round
        )
      end
    end
    save
  end

private
  def set_defaults
    self.round = 0
  end

  def delay_start
    delay(run_at: start_date).next_round!
  end
end
