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

  self.per_page = 20

  def self.upcoming
    where(arel_table[:start_date].gteq(DateTime.now))
  end

  def self.finished
    where(arel_table[:start_date].lt(DateTime.now))
  end

  def build_rule(params)
    self.rule = self.rule_type.constantize.new(params)
  end

  def check_rule_for(player)
    rule.blank? || rule.is_satisfied_by?(player)
  end

private
  def set_defaults
    self.round = 0
  end
end
