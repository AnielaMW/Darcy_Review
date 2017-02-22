require "rails_helper"

feature "delete review", %Q{
  As an authorized user
  I want to delete a Review for an Actor
  So that no one can review it
  } do

    # ACCEPTANCE CRITERIA
    # * User must be the original creator of the Actor, the Review or an admin.
    # * If User is not the original creator of the Actor, the Review, nor an admin the User cannot see a delete link.

  scenario "sucessfully delete review when user is review creator" do
    review = FactoryGirl.create(:review)

    sign_in review.user
    visit review_path(review[:id])
    click_link "Delete Review"

    expect(page).to have_current_path(actor_path(review[:actor_id]))
    expect(page).not_to have_content("#{review[:description]}")
    expect(page).not_to have_content("#{review[:rating]}")
  end

  scenario "sucessfully delete review when user is actor creator" do
    review = FactoryGirl.create(:review)

    sign_in review.actor.user
    visit review_path(review[:id])
    click_link "Delete Review"

    expect(page).not_to have_content("#{review[:description]}")
    expect(page).not_to have_content("#{review[:rating]}")
  end

  scenario "sucessfully delete actor when user is admin" do
    jane = FactoryGirl.create(:jane)
    review = FactoryGirl.create(:review)

    sign_in jane
    visit review_path(review[:id])
    click_link "Delete Review"

    expect(page).not_to have_content("#{review[:description]}")
    expect(page).not_to have_content("#{review[:rating]}")
  end

  scenario "fails to see delete actor option when user is neither creator nor admin" do
    lizzie = FactoryGirl.create(:lizzie)
    review = FactoryGirl.create(:review)

    visit review_path(review[:id])

    expect(page).not_to have_content("Delete Review")

    sign_in lizzie
    visit review_path(review[:id])

    expect(page).not_to have_content("Delete Review")
  end
end
