require "rails_helper"

feature "view actor index", %Q{
  As an authenticated user
  I want to view a list of items
  So that I can pick items to review
  } do

    # ACCEPTANCE CRITERIA
    # * User should be authenticated.
    # * User should be able to view a list of actors.
    # * User should get an error if not signed_in.

  scenario "sucessfully view actor list when signed_in" do
    lizzie = FactoryGirl.create(:user)
    colin = FactoryGirl.create(:actor)
    olie = FactoryGirl.create(:olie)

    sign_in lizzie
    visit root_path

    expect(page).to have_content("#{colin[:first_name]} #{colin[:last_name]}")
    expect(page).to have_content("#{olie[:first_name]} #{olie[:last_name]}")
  end

  scenario "fail to view actor list when not signed_in" do
    colin = FactoryGirl.create(:actor)
    olie = FactoryGirl.create(:olie)

    visit root_path

    expect(page).not_to have_content("#{colin[:first_name]} #{colin[:last_name]}")
    expect(page).not_to have_content("#{olie[:first_name]} #{olie[:last_name]}")
  end
end
