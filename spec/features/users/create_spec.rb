require "rails_helper"

RSpec.describe "User Registration Page" do
  it "should be able to fill in a form and create a new user" do
    visit register_path

    name = "Billie Jo"
    email = "ethreal_tarsier@gmail.com"
    password = "test"

    fill_in :user_name, with: name
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password

    click_button "Register"
    new_user = User.last

    expect(current_path).to eq(user_path(new_user))
    expect(page).to have_content("Billie Jo")
  end

  it "should be prompted to fill in valid information if invalid information is submitted" do
    visit register_path

    fill_in :user_name, with: ""
    fill_in :user_email, with: ""
    fill_in :user_password, with: ""
    fill_in :user_password_confirmation, with: ""

    click_button "Register"
   
    expect(current_path).to eq("/register")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password digest can't be blank")
    expect(page).to have_content("Password can't be blank")

    expect(current_path).to eq(register_path)
  end

  it "will not create a user without password confirmation" do 
    visit register_path

    name = "Billie Jo"
    email = "ethreal_tarsier@gmail.com"
    password = "test"

    fill_in :user_name, with: name
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: ""

    click_button "Register"

    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
