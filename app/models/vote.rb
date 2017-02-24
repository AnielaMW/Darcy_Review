class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :review

  RATING = [
    [1, "Agree"],
    [-1, "Disagree"]
  ]
end
