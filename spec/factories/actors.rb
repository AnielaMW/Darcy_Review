FactoryGirl.define do
  factory :actor do
    sequence(:first_name) { |n| "Colin#{n}" }
    sequence(:last_name) { |n| "Firth#{n}" }
    year 1995
    user
    factory :olie do
      sequence(:first_name) { |n| "Laurence#{n}" }
      sequence(:last_name) { |n| "Olivier#{n}" }
      description "Elizabeth Bennet: Oh Mr. Darcy, Miss Bingley here is eager for her lesson. I hope you will enjoy it, Miss Bingley, and that you will learn to direct your darts with greater accuracy."
      movie "Pride and Prejudice"
      book_title "Pride and Prejudice"
      year 1940
      user
    end
  end
end
