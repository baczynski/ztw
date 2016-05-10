class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  has_and_belongs_to_many :tournaments
  has_one :address, as: :addressable

  accepts_nested_attributes_for :address

  validates :password_confirmation, presence: true, on: :create

  after_initialize :check_address

private
  def check_address
    build_address unless address
  end
end
