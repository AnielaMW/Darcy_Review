class Review < ApplicationRecord
  belongs_to :user
  belongs_to :actor
  has_many :votes

end
