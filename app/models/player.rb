class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :tournaments
  has_one :address, as: :addressable

  accepts_nested_attributes_for :address

  validates :password_confirmation, presence: :true
end
