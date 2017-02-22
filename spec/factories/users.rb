FactoryGirl.define do
  factory :user, aliases: [:lizzie] do
    sequence(:first_name) { |n| "Lizzie#{n}" }
    sequence(:last_name) { |n| "Bennet#{n}" }
    sequence(:email) { |n| "wit#{n}@longbourne.uk" }
    sequence(:password) { |n| "dadsfavgirl#{n}" }

    factory :admin_user, aliases: [:jane] do
      sequence(:first_name) { |n| "Jane#{n}" }
      sequence(:last_name) { |n| "Bennet#{n}" }
      sequence(:email) { |n| "living#{n}@netherfield.uk" }
      sequence(:password) { |n| "bingleysbabe" }
      role "admin"
    end
  end
end
