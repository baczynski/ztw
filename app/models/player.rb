class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  alias_attribute :coef, :development_coefficient

  has_and_belongs_to_many :tournaments
  has_one :address, as: :addressable
  has_many :white_matches, class_name: 'Match', foreign_key: 'white_player_id'
  has_many :black_matches, class_name: 'Match', foreign_key: 'black_player_id'

  accepts_nested_attributes_for :address

  validates :password_confirmation, presence: true, on: :create
  validates :date_of_birth, date: {allow_blank: true, before: proc {Time.now}}

  after_initialize :check_address
  before_update :update_coefficient, if: :rating_changed?

  def matches
    self.white_matches | self.black_matches
  end

  def full_name
    (first_name.blank? ? '' : first_name + ' ') + surname.to_s
  end

  def to_s
    full_name.blank? ? email : full_name
  end

  def age
    if date_of_birth.present?
      year_diff = Date.today.year - date_of_birth.year
      year_diff -= 1 if date_of_birth.years_since(year_diff) > Date.today
      year_diff
    end
  end

  def has_address?
    !!address.id
  end

  def tournaments_count
    tournaments.finished.count
  end

private
  def check_address
    build_address unless address
  end

  def update_coefficient
    unless coef == 10
      if matches.size < 30 || (age < 18 && rating < 2300)
        coef = 40
      elsif rating < 2400
        coef = 20
      else
        coef = 10
      end
    end
  end
end
