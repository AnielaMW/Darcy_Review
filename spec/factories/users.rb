FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "Lizzie#{n}" }
    sequence(:last_name) { |n| "Bennet#{n}" }
    sequence(:email) { |n| "wit#{n}@longbourne.uk" }
    sequence(:password) { |n| "dadsfavgirl#{n}" }
  end
end
