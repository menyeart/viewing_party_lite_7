require "rails_helper"

RSpec.describe "User Login Form Page" do
  let!(:phil) { User.create!(name: "Philip", email: "philipjfry@gmail.com", password: "password") }
  it "should be able to fill in a form and log in an existing user" do
    visit login_path

    fill_in :email, with: "philipjfry@gmail.com"
    fill_in :password, with: "password"
    click_button "Log In"

    expect(current_path).to eq(user_path(phil))
    expect(page).to have_content("Welcome, #{phil.name}")
    expect(page).to have_content("#{phil.name}'s Dashboard")
  end

  it "should redirect the user to the log in page if invalid credentials are supplied" do
    visit login_path

    fill_in :email, with: "philipjfry@gmail.com"
    fill_in :password, with: "passwor"
    click_button "Log In"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Sorry, your credentials are bad.")
  end

  it "should show a list of user emails if the user is logged in" do
    visit root_path
    click_link "Log In"
    fill_in :email, with: "philipjfry@gmail.com"
    fill_in :password, with: "password"
    click_button "Log In"
    visit root_path

    expect(page).to have_content("philipjfry@gmail.com")
  end
end
