require "rails_helper"

feature "edit review", %Q{
  As an authorized user
  I want to update a review's information
  So that I can correct errors or provide new information
  } do

    # ACCEPTANCE CRITERIA
    # * User must be the original creator of the Review or an admin.
    # * User must specify description
    # * User must specify rating
    # * If User is not the original creator of the Review nor an admin the User cannot see an edit link.
    # * If all required information is complete, Review is editd.
    # * If required information is incomplete, Review is not edited and user gets error message.

  scenario "sucessfully edit review when user is creator" do
    review = FactoryGirl.create(:review)
    edit_review = {description: "He's a natural red-head.", rating: 10}

    sign_in review.user
    visit review_path(review.id)
    click_link "Edit Review"

    expect(page).to have_current_path(edit_review_path(review.id))

    fill_in "Description", with: edit_review[:description]
    fill_in "Rating", with: edit_review[:rating]
    click_button "Update Review"

    expect(page).to have_current_path(review_path(review.id))
    expect(page).to have_content(edit_review[:description])
    expect(page).to have_content(edit_review[:rating])
  end

  scenario "fails to edit review when user is creator and enters invalid information" do
    review = FactoryGirl.create(:review)
    edit_review = {description: "", rating: ""}

    sign_in review.user
    visit edit_review_path(review.id)
    fill_in "Description", with: edit_review[:description]
    fill_in "Rating", with: edit_review[:rating]
    click_button "Update Review"

    expect(page).not_to have_current_path(review_path(review.id))
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Rating can't be blank")
  end

  scenario "sucessfully edit review when user is admin and enters all information" do
    jane = FactoryGirl.create(:jane)
    review = FactoryGirl.create(:review)
    edit_review = {description: "He's a natural red-head.", rating: 10}

    sign_in jane
    visit edit_review_path(review.id)
    fill_in "Description", with: edit_review[:description]
    fill_in "Rating", with: edit_review[:rating]
    click_button "Update Review"

    expect(page).to have_current_path(review_path(review.id))
    expect(page).to have_content(edit_review[:description])
  end

  scenario "fails to edit review when user is admin and enters invalid information" do
    jane = FactoryGirl.create(:jane)
    review = FactoryGirl.create(:review)
    edit_review = {description: "He's a natural red-head.", rating: 10}

    sign_in jane
    visit edit_review_path(review.id)
    fill_in "Description", with: edit_review[:description]
    fill_in "Rating", with: edit_review[:rating]
    click_button "Update Review"

    expect(page).not_to have_current_path(review_path(review.id))
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Rating can't be blank")
  end

  scenario "fails to see edit review option when user is neither creator nor admin" do
    lizzie = FactoryGirl.create(:lizzie)
    review = FactoryGirl.create(:review)

    visit review_path(review.id)

    expect(page).not_to have_content("Edit Review")

    sign_in lizzie
    visit review_path(review.id)

    expect(page).not_to have_content("Edit Review")
  end
end
