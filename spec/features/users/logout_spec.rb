require "rails_helper"

RSpec.describe "User Logout" do
  let!(:phil) { User.create!(name: "Philip", email: "philipjfry@gmail.com", password: "password") }
  it "should be able to log out a logged in user" do
    visit root_path

    expect(page).to have_button("Create New User")
    expect(page).to have_link("Log In")
    expect(page).to_not have_link("Log Out")

    click_link "Log In"
    fill_in :email, with: "philipjfry@gmail.com"
    fill_in :password, with: "password"
    click_button "Log In"
    visit root_path

    expect(current_path).to eq(root_path)
    expect(page).to_not have_link("Log In")
    expect(page).to_not have_link("Create New User")
    expect(page).to have_content("Log Out")

    click_link "Log Out"
   
    expect(current_path).to eq(root_path)
    expect(page).to_not have_link("Log Out")
    expect(page).to have_button("Create New User")
    expect(page).to have_link("Log In")
  end

  it "should not be able to see a list of existing users as a visitor(not logged in)" do
    visit root_path
    
    expect(page).to_not have_content("Philip")
    expect(page).to_not have_content("philipjfry@gmail.com")
  
    click_link "Log In"
    fill_in :email, with: "philipjfry@gmail.com"
    fill_in :password, with: "password"
    click_button "Log In"
    visit root_path

    expect(page).to have_content("philipjfry@gmail.com")
  end

  it "should not be able to see a list of existing users as a visitor(not logged in)" do
    visit root_path
    expect(page).to_not have_content("Philip")
    expect(page).to_not have_content("philipjfry@gmail.com")
  end

  it "should not allow a visitor(not logged in) to view the dashboard page" do
    visit root_path
    click_link "Dashboard"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You must be logged in to visit the dashboard")
  end

  it "should not allow a visitor(not logged in) to create a new viewing party", :vcr do
    visit user_discover_index_path(phil)
    click_button "Discover Top Rated Movies"
    click_link "The Godfather"
    click_button "Create Viewing Party"

    expect(current_path).to eq(auth_movie_path(238))
    expect(page).to have_content("You must be logged in to create a viewing party")
  end
end