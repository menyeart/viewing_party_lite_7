require "rails_helper"

RSpec.describe "User Login Form Page" do
  let!(:phil) { User.create!(name: "Philip", email: "philipjfry@gmail.com", password: "password") }
  let!(:bob) { User.create!(name: "Bob", email: "bob@gmail.com", password: "password", role: 2) }
  it "should be able to fill in a form and log in an existing user" do
    visit login_path

    fill_in :email, with: "philipjfry@gmail.com"
    fill_in :password, with: "password"
    click_button "Log In"

    expect(current_path).to eq("/dashboard")
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

  it "redirects admin users to an admin dashboard where the user will see a list of all users default email addresses" do
   
    visit root_path
    click_link "Log In"
    fill_in :email, with: bob.email
    fill_in :password, with: bob.password
    click_button "Log In"

    expect(page).to have_link("philipjfry@gmail.com")
    expect(page).to_not have_link("bob@gmail.com")
  end
end
