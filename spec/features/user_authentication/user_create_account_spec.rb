require "rails_helper"

feature "create account", %Q{
  As a prospective user
  I want to create an account
  So that I can post items and review them
  } do

    # ACCEPTANCE CRITERIA
    # * User must specify first_name
    # * User must specify last_name
    # * User must specify email
    # * User must specify and confirm password.
    # * If all information is complete, User is registered and authenticated.
    # * If information is incomplete, User gets error message.


  scenario "sucessfully create account when user enters valid information" do
    jane = {first_name: "Jane", last_name: "Bennet", email: "living@netherfield.uk", password: "bingleysbabe"}

    visit root_path
    click_link 'Sign Up'
    fill_in "First Name", with: "#{jane[:first_name]}"
    fill_in "Last Name", with: "#{jane[:last_name]}"
    fill_in "Email", with: "#{jane[:email]}"
    fill_in "Password", with: "#{jane[:password]}"
    fill_in "Confirm Password", with: "#{jane[:password]}"
    click_button "Sign Up"

    expect(page).to have_content("Welcome! Your favorite Darcy awaits.")
    expect(page).to have_content("Sign Out")
  end

  scenario "fails to create account when user enters invalid information" do
    visit root_path
    click_link 'Sign Up'
    click_button "Sign Up"

    expect(page).to have_content("errors prohibited this user from being saved:")
    expect(page).to have_content("Sign Up")
  end

  scenario "fails to create account when user password and confirm password don't match" do
    mary = {first_name: "Mary", last_name: "Bennet", email: "studying@longbourne.uk", password: "fordycerules"}

    visit root_path
    click_link 'Sign Up'
    fill_in "First Name", with: "#{mary[:first_name]}"
    fill_in "Last Name", with: "#{mary[:last_name]}"
    fill_in "Email", with: "#{mary[:email]}"
    fill_in "Password", with: "#{mary[:password]}"
    fill_in "Confirm Password", with: "lonelysis"
    click_button "Sign Up"

    expect(page).to have_content("Password confirmation doesn't match")
    expect(page).to have_content("Sign Up")
  end
end
