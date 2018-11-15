require "rails_helper"

feature "view actor index", %Q{
  As a user
  I want to view a list of items
  So that I can pick items to review
  } do

    # ACCEPTANCE CRITERIA
    # * User should be able to view a list of actors.
    # * User should get an error if not signed_in.

  scenario "sucessfully view actor list" do
    colin = FactoryGirl.create(:colin)
    olie = FactoryGirl.create(:olie)

    visit root_path

    expect(page).to have_content(colin.full_name)
    expect(page).to have_content(olie.full_name)
  end
end
