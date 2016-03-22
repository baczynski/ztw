class Tournament < ActiveRecord::Base
  validates :name, :description, :start_date, :tournament_type, :rounds, presence: true
  validates :tournament_type, inclusion: {in: ['ONSITE', 'ONLINE']}

  self.per_page = 20
end
