require "rails_helper"

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create(name: "Phil", email: "philipjfry338@gmail.com", password: "testing123")

    visit root_path

    click_link "Log In"

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Login"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Welcome, Phil!")
  end

  it "will not allow login with invalid credentials" do
    user = User.create(name: "Phil", email: "philipjfry338@gmail.com", password: "testing123")

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: "not_the_right_password"

    click_on "Login"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Sorry your credentials are bad.")
  end
end