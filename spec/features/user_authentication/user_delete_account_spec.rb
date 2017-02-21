require "rails_helper"

feature "deletes account", %Q{
  As an authenticated user
  I want to delete my account
  So that my information is no longer retained by the app
  } do

    # ACCEPTANCE CRITERIA
    # * User can delete account

  scenario "sucessfully delete account" do
    lizzie = FactoryGirl.create(:user)

    sign_in lizzie
    visit root_path
    click_link 'Update Profile'
    click_button "Cancel my account"

    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Sign In")
  end
end
