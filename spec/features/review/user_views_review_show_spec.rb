require "rails_helper"

feature "view review show", %Q{
  As a user
  I want to view the details of a Review
  So that I can get more information about it
  } do

    # ACCEPTANCE CRITERIA
    # * User should be able to click a link from the Actor's show page to view the details of a review.

  scenario "sucessfully view full review details" do
    review = FactoryGirl.create(:review)

    visit actor_path(review[:actor_id])
    click_link "#{review[:id]}"

    expect(page).to have_content("#{review[:description]}")
    expect(page).to have_content("#{review[:rating]}")
    expect(page).to have_content("#{review.user[:first_name]}")
  end
end
