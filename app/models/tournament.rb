class Tournament < ActiveRecord::Base
  TOURNAMENT_TYPE = {
    'ONSITE' => 'on-site',
    'ONLINE' => 'on-line'
  }

  validates :name, :description, :start_date, :tournament_type, :rounds, presence: true
  validates :tournament_type, inclusion: {in: TOURNAMENT_TYPE.keys}
  validates :name, :start_date, uniqueness: {case_sensitive: false}
  validates :rounds, numericality: {only_integer: true, greater_than: 0}

  self.per_page = 20

  has_many :matches
end
