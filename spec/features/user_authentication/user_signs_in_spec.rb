require "rails_helper"

feature "sign_in to account", %Q{
  As an unauthenticated user
  I want to sign in
  So that I can post items and review them
  } do

    # ACCEPTANCE CRITERIA
    # * User provide email
    # * User provide password
    # * If information is incomplete, User gets error message.
    # * If information is invalid, User gets error message.

  scenario "sucessfully sign_in when user enters valid information" do
    lizzie = FactoryGirl.create(:lizzie)

    visit root_path
    click_link 'Sign In'
    fill_in "Email", with: "#{lizzie.email}"
    fill_in "Password", with: "#{lizzie.password}"
    click_button "Sign In"

    expect(page).to have_content("Sign Out")
  end

  scenario "fails to sign_in when user enters incomplete information" do
    visit root_path
    click_link 'Sign In'
    click_button "Sign In"

    expect(page).to have_content("Invalid Email or password")
    expect(page).to have_content("Sign In")
  end

  scenario "fails to sign_in when user enters invalid email" do
    lydia = FactoryGirl.create(:lizzie)

    visit root_path
    click_link 'Sign In'
    fill_in "Email", with: "lydia@brighton.com"
    fill_in "Password", with: "#{lydia.password}"
    click_button "Sign In"

    expect(page).to have_content("Invalid Email or password")
    expect(page).to have_content("Sign In")
  end

  scenario "fails to sign_in when user enters invalid password" do
    lydia = FactoryGirl.create(:lizzie)

    visit root_path
    click_link 'Sign In'
    fill_in "Email", with: "#{lydia.email}"
    fill_in "Password", with: "momsnewfavgirl"
    click_button "Sign In"

    expect(page).to have_content("Invalid Email or password")
    expect(page).to have_content("Sign In")
  end
end
