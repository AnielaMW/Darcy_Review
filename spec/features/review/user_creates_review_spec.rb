require "rails_helper"

feature "create review", %Q{
  As an authenticated user
  I want to add a Review to an Actor
  So that others can vote on it
  } do

    # ACCEPTANCE CRITERIA
    # * User must be Authenticated
    # * From the Actor show page.
    # * User must specify a description
    # * User must specify a rating 1-10
    # * If all required information is complete, Review is created.
    # * If required information is incomplete, Review is not created and user gets error message.

  scenario "sucessfully create review for an actor with an authenticated user" do
    lizzie = FactoryGirl.create(:lizzie)
    colin = FactoryGirl.create(:colin)
    review_colin = {description: "He's a hottie", rating: 10}

    sign_in lizzie
    visit actor_path(colin[:id])
    click_link 'Create New Review'
    fill_in "Description", with: "#{review_colin[:description]}"
    fill_in "Rating", with: "#{review_colin[:rating]}"
    click_button 'Create Review'

    expect(page).to have_content("#{lizzie[:first_name]}")
    expect(page).to have_content("#{review_colin[:description]}")
    expect(page).to have_content("#{review_colin[:rating]}")
  end

  scenario "fails to create review when user enters invalid information" do
    lizzie = FactoryGirl.create(:lizzie)
    colin = FactoryGirl.create(:colin)

    sign_in lizzie
    visit new_actor_review_path(colin[:id])
    click_button 'Create Review'

    expect(page).to have_content("Rating can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario "fails to create review for an actor with an unauthenticated user" do
    colin = FactoryGirl.create(:colin)

    visit actor_path(colin[:id])

    expect(page).not_to have_content("Create New Review")
  end
end
