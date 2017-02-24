FactoryGirl.define do
  factory :vote do
    rating 1
    review
    user

    factory :lower_review do
      rating -1
    end

    factory :higher_review do
    end
  end
end
