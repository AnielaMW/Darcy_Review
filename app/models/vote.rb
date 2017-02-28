class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :review

  RATING = [
    [true, "Agree"],
    [false, "Disagree"]
  ]

  validates :rating, inclusion: { in: [true, false] }
  validates :user_id, presence: true
  validates :review_id, presence: true
end
