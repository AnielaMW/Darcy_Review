class Review < ApplicationRecord
  belongs_to :user
  belongs_to :actor
  has_many :votes

  RATINGS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

  validates :description, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :user_id, presence: true
  validates :actor_id, presence: true
end
