class Actor < ApplicationRecord
  belongs_to :user
  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :year, allow_blank: true, numericality: { only_integer: true, greater_than_or_equal_to: 1813 }
  validates :user_id, presence: true

  def full_name
    [first_name, last_name].join(' ')
  end

  before_save :blank_nil

  def blank_nil
    nills = %w( movie book_title description)
    nills.each { |att| self[att] = nil if self[att].blank? }
  end
end
