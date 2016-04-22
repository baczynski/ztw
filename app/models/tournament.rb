class Tournament < ActiveRecord::Base
  TOURNAMENT_TYPE = {
    'ONSITE' => 'on-site',
    'ONLINE' => 'on-line'
  }

  has_and_belongs_to_many :players
  has_many :matches

  validates :name, :description, :start_date, :tournament_type, :rounds, presence: true
  validates :tournament_type, inclusion: {in: TOURNAMENT_TYPE.keys}
  validates :name, :start_date, uniqueness: {case_sensitive: false}
  validates :rounds, numericality: {only_integer: true, greater_than: 0}

  self.per_page = 20

  def self.upcoming
    where(arel_table[:start_date].gteq(DateTime.now))
  end

  def self.finished
    where(arel_table[:start_date].lt(DateTime.now))
  end
end
