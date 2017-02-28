FactoryGirl.define do
  factory :vote do
    rating "1"
    review
    user

    factory :lower_vote do
      rating "-1"
    end

    factory :higher_vote do
    end
  end
end
