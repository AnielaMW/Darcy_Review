class User < ApplicationRecord
  has_many :actors
  has_many :reviews
  has_many :votes

  ROLES = ['basic', 'admin']
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true

  def admin?
    role == "admin"
  end
end
