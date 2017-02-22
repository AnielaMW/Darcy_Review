require "rails_helper"

feature "view actor show", %Q{
  As a user
  I want to view the details of an Actor
  So that I can get more information about it
  } do

    # ACCEPTANCE CRITERIA
    # * User should be able to click a link from the index to view the details of an actor.
    # * User should be able to view only the available details of an actor.
    # * User should not see a detail section if the information is unavailable.

  scenario "sucessfully view full actor details" do
    colin = FactoryGirl.create(:colin)
    olie = FactoryGirl.create(:olie)

    visit root_path
    click_link "#{olie.full_name}"

    expect(page).to have_current_path("/actors/#{olie[:id]}")
    expect(page).to have_content("#{olie[:first_name]} #{olie[:last_name]}")
    expect(page).to have_content("#{olie[:description]}")
    expect(page).to have_content("#{olie[:movie]}")
    expect(page).to have_content("#{olie[:book_title]}")
    expect(page).to have_content("#{olie[:year]}")
  end

  scenario "sucessfully view available actor details" do
    colin = FactoryGirl.create(:colin)

    visit "/actors/#{colin[:id]}"

    expect(page).to have_current_path("/actors/#{colin[:id]}")
    expect(page).to have_content("#{colin[:first_name]} #{colin[:last_name]}")
    expect(page).not_to have_content("Movie")
    expect(page).not_to have_content("Book Title")
    expect(page).not_to have_content("()")
    expect(page).not_to have_content("Description")
  end
end
