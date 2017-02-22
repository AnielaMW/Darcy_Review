FactoryGirl.define do
  factory :review do
    sequence(:description) { |n| "He's ok. #{n}" }
    rating 9
    actor
    user
  end
end
