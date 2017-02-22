require "rails_helper"

feature "view review from actor show", %Q{
  As a user
  I want to view a list of reviews
  So that I can pick items to vote on
  } do

    # ACCEPTANCE CRITERIA
    # * User should be able to view a list of actors.
    # * User should get an error if not signed_in.

  scenario "sucessfully view review list" do
    review = FactoryGirl.create(:review)

    visit actor_path(review.actor_id)

    expect(page).to have_content(review.description)
    expect(page).to have_content(review.rating)
    expect(page).to have_content(review.user.first_name)
  end
end
