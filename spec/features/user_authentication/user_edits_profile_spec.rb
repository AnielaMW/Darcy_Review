require "rails_helper"

feature "edits account", %Q{
  As an authenticated user
  I want to update my information
  So that I can keep my profile up to date
  } do

    # ACCEPTANCE CRITERIA
    # * User can edit first_name
    # * User can edit last_name
    # * User can edit email
    # * If all information is complete, User is updated.
    # * If information is incomplete, User gets error message.

  scenario "sucessfully update account when user enters valid information" do
    lizzie = FactoryGirl.create(:lizzie)
    elizabeth = {first_name: "Elizabeth", last_name: "Darcy", email: "love@pemberly.uk"}

    sign_in lizzie
    visit root_path
    click_link 'Update Profile'
    fill_in "First Name", with: "#{elizabeth[:first_name]}"
    fill_in "Last Name", with: "#{elizabeth[:last_name]}"
    fill_in "Email", with: "#{elizabeth[:email]}"
    fill_in "Password", with: "#{lizzie.password}"
    fill_in "Confirm Password", with: "#{lizzie.password}"
    fill_in "Current Password", with: "#{lizzie.password}"
    click_button "Update"

    expect(page).to have_content("Sign Out")
  end

  scenario "fails to update account when user enters invalid information" do
    lizzie = FactoryGirl.create(:lizzie)

    sign_in lizzie
    visit root_path
    click_link 'Update Profile'
    fill_in "First Name", with: ""
    fill_in "Last Name", with: ""
    fill_in "Email", with: ""
    click_button "Update"

    expect(page).to have_content("errors prohibited this user from being saved:")
  end
end
