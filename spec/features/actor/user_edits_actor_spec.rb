require "rails_helper"

feature "edit actor", %Q{
  As an authorized user
  I want to update an item's information
  So that I can correct errors or provide new information
  } do

    # ACCEPTANCE CRITERIA
    # * User must be the original creator of the Actor or an admin.
    # * User must specify first_name
    # * User must specify last_name
    # * User may specify description, movie, book_title, and/or year
    # * If User is not the original creator of the Actor nor an admin the User cannot see an edit link.
    # * If all required information is complete, Actor is editd.
    # * If required information is incomplete, Actor is not edited and user gets error message.

  scenario "sucessfully edit actor when user is creator and enters all information" do
    lizzie = FactoryGirl.create(:lizzie)
    olie = FactoryGirl.create(:olie, user_id: lizzie.id)
    edit_olie = {description: "He prefered Vivien Leigh to Elizabeth Bennet."}

    sign_in lizzie
    visit "/actors/#{olie[:id]}"
    click_link "Edit Actor"

    expect(page).to have_current_path("/actors/#{olie[:id]}/edit")

    fill_in "Description", with: "#{edit_olie[:description]}"
    click_button "Update Actor"

    expect(page).to have_current_path("/actors/#{olie[:id]}")
    expect(page).to have_content("#{edit_olie[:description]}")
  end

  scenario "sucessfully edit actor when user is creator and enters only required information" do
    lizzie = FactoryGirl.create(:lizzie)
    colin = FactoryGirl.create(:colin, user_id: lizzie.id)
    edit_colin = {year: 1995}

    sign_in lizzie
    visit "/actors/#{colin[:id]}/edit"
    fill_in "Year", with: "#{edit_colin[:year]}"
    click_button "Update Actor"

    expect(page).to have_current_path("/actors/#{colin[:id]}")
    expect(page).to have_content(edit_colin[:year])
  end

  scenario "fails to edit actor when user is creator and enters invalid information" do
    lizzie = FactoryGirl.create(:lizzie)
    colin = FactoryGirl.create(:colin, user_id: lizzie.id)
    edit_colin = {first_name: ""}

    sign_in lizzie
    visit "/actors/#{colin[:id]}/edit"
    fill_in "First Name", with: "#{edit_colin[:first_name]}"
    click_button "Update Actor"

    expect(page).not_to have_current_path("/actors/#{colin[:id]}")
    expect(page).to have_content("First name can't be blank")
  end

  scenario "sucessfully edit actor when user is admin and enters all information" do
    jane = FactoryGirl.create(:jane)
    olie = FactoryGirl.create(:olie)
    edit_olie = {description: "He prefered Vivien Leigh to Elizabeth Bennet."}

    sign_in jane
    visit "/actors/#{olie[:id]}"
    click_link "Edit Actor"

    expect(page).to have_current_path("/actors/#{olie[:id]}/edit")

    fill_in "Last Name", with: "#{edit_olie[:description]}"
    click_button "Update Actor"

    expect(page).to have_current_path("/actors/#{olie[:id]}")
    expect(page).to have_content(edit_olie[:description])
    sign_in jane

    expect(page).to have_current_path("/actors/#{olie[:id]}")
    expect(page).to have_content("#{edit_olie[:description]}")
  end

  scenario "sucessfully edit actor when user is admin and enters only required information" do
    jane = FactoryGirl.create(:jane)
    colin = FactoryGirl.create(:colin)
    edit_colin = {year: 1995}

    sign_in jane
    visit "/actors/#{colin[:id]}/edit"
    fill_in "Year", with: "#{edit_colin[:year]}"
    click_button "Update Actor"

    expect(page).to have_current_path("/actors/#{colin[:id]}")
    expect(page).to have_content(edit_colin[:year])
  end

  scenario "fails to edit actor when user is admin and enters invalid information" do
    jane = FactoryGirl.create(:jane)
    colin = FactoryGirl.create(:colin)
    edit_colin = {first_name: ""}

    sign_in jane
    visit "/actors/#{colin[:id]}/edit"
    fill_in "First Name", with: "#{edit_colin[:first_name]}"
    click_button "Update Actor"

    expect(page).not_to have_current_path("/actors/#{colin[:id]}")
    expect(page).to have_content("First name can't be blank")
  end

  scenario "fails to see edit actor option when user is neither creator nor admin" do
    lizzie = FactoryGirl.create(:lizzie)
    colin = FactoryGirl.create(:colin)

    visit "/actors/#{colin[:id]}"

    expect(page).not_to have_content("Edit Actor")

    sign_in lizzie
    visit "/actors/#{colin[:id]}"

    expect(page).not_to have_content("Edit Actor")

  end
end
