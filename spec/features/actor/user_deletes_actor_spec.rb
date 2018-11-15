require "rails_helper"

feature "delete actor", %Q{
  As an authorized user
  I want to delete an item
  So that no one can review it
  } do

    # ACCEPTANCE CRITERIA
    # * User must be the original creator of the Actor or an admin.
    # * If User is not the original creator of the Actor nor an admin the User cannot see a delete link.

  scenario "sucessfully delete actor when user is creator" do
    olie = FactoryGirl.create(:olie)

    sign_in olie.user
    visit actor_path(olie.id)
    click_link "Delete Actor"

    expect(page).to have_current_path(root_path)
    expect(page).not_to have_content(olie.full_name)
  end

  scenario "sucessfully delete actor when user is admin" do
    jane = FactoryGirl.create(:jane)
    olie = FactoryGirl.create(:olie)

    sign_in jane
    visit actor_path(olie.id)
    click_link "Delete Actor"

    expect(page).to have_current_path(root_path)
    expect(page).not_to have_content(olie.full_name)
  end

  scenario "fails to see delete actor option when user is neither creator nor admin" do
    lizzie = FactoryGirl.create(:lizzie)
    colin = FactoryGirl.create(:colin)

    visit actor_path(colin.id)

    expect(page).not_to have_content("Delete Actor")

    sign_in lizzie
    visit actor_path(colin.id)

    expect(page).not_to have_content("Delete Actor")
  end
end
