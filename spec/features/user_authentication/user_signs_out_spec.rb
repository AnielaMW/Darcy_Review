require "rails_helper"

feature "sign_out of account", %Q{
  As an authenticated user
  I want to sign out
  So that no one else can post items or reviews on my behalf
  } do

    # ACCEPTANCE CRITERIA
    # * User signs out

  scenario "sucessfully sign_out when user signs_out" do
    lizzie = FactoryGirl.create(:user)

    sign_in lizzie
    visit root_path
    click_link 'Sign Out'

    expect(page).to have_content("Sign In")
  end
end
