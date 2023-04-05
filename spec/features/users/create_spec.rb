require "rails_helper"

RSpec.describe "User Registration Page" do
  it "should be able to fill in a form and create a new user" do
    visit "/register"

    fill_in :name, with: "Matt Smith"
    fill_in :email, with: "mattsmith@emails.com"
    fill_in :password, with: "password"
    fill_in :password_confirmation, with: "password"

    click_button "Register"
    new_user = User.last
    expect(new_user).to_not have_attribute(:password)
    expect(new_user.password_digest).to_not eq("password")
    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("Matt Smith")
  end

  it "should be prompted to fill in valid information if invalid information is submitted" do
    visit "/register"

    fill_in :name, with: ""
    fill_in :email, with: "mattsmith@emails.com"
    fill_in :password, with: "password"
    fill_in :password_confirmation, with: "password"

    click_button "Register"
    new_user = User.last
    expect(current_path).to eq("/register")
    expect(page).to have_content("Name can't be blank")
  end

  it "it should redirect to '/register' if I fail to fill in my name, unique email, OR matching passwords" do
    visit "/register"

    fill_in :name, with: "Matt"
    fill_in :email, with: "mattsmith@emails.com"
    fill_in :password, with: "password"
    fill_in :password_confirmation, with: ""

    click_button "Register"
 
    new_user = User.last
    expect(current_path).to eq("/register")
    expect(page).to have_content("Passwords do not match")
  end
end
