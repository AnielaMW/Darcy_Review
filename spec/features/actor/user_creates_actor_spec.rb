require "rails_helper"

feature "create actor", %Q{
  As an authenticated user
  I want to add an item
  So that others can review it
  } do

    # ACCEPTANCE CRITERIA
    # * User must specify first_name
    # * User must specify last_name
    # * User may specify description, movie, book_title, and/or year
    # * If all required information is complete, Actor is created.
    # * If required information is incomplete, Actor is not created and user gets error message.

  scenario "sucessfully create actor when user enters all information" do
    lizzie = FactoryGirl.create(:user)
    sam = {first_name: "Sam", last_name: "Riley", description: "A Darcy that can lock swords as well as lips. ;)", movie: "Pride and Prejudice and Zombies", book_title: "Pride and Prejudice and Zombies", year: 2016}

    sign_in lizzie
    visit root_path
    click_link 'Create New Darcy'
    fill_in "First Name", with: "#{sam[:first_name]}"
    fill_in "Last Name", with: "#{sam[:last_name]}"
    fill_in "Description", with: "#{sam[:description]}"
    fill_in "Movie", with: "#{sam[:movie]}"
    fill_in "Book Title", with: "#{sam[:book_title]}"
    fill_in "Year", with: "#{sam[:year]}"
    click_button 'Create Actor'

    expect(page).to have_content("#{sam[:first_name]} #{sam[:last_name]}")
  end

  scenario "sucessfully create actor when user enters only required information" do
    lizzie = FactoryGirl.create(:user)
    matt = {first_name: "Matthew", last_name: "Macfadyen"}

    sign_in lizzie
    visit root_path
    click_link 'Create New Darcy'
    fill_in "First Name", with: "#{matt[:first_name]}"
    fill_in "Last Name", with: "#{matt[:last_name]}"
    click_button 'Create Actor'

    expect(page).to have_content("#{matt[:first_name]} #{matt[:last_name]}")
  end

  scenario "fails to create actor when user enters invalid information" do
    lizzie = FactoryGirl.create(:user)

    sign_in lizzie
    visit root_path
    click_link 'Create New Darcy'
    click_button 'Create Actor'

    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
  end
end
