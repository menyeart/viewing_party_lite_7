require "rails_helper"

RSpec.describe "Logging Out" do
  describe "As a logged in user, When I visit the landing page" do 
    it "does not display a link to log in or create an account" do
      user = User.create(name: "Phil", email: "philipjfry338@gmail.com", password: "testing123")

      visit root_path
      click_link "Log In"

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Login"
      expect(current_path).to eq(dashboard_path)
      
      click_link "Landing Page"
     
      expect(current_path).to eq(root_path)

      expect(page).to have_link("Log Out")
      expect(page).to_not have_link("Log In")
      expect(page).to_not have_link("Create New User")
    end

    it "when I click the link to log out I am taken to the landing page and I see the log in link" do 
      user = User.create(name: "Phil", email: "philipjfry338@gmail.com", password: "testing123")

      visit root_path
      click_link "Log In"

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Login"
      expect(current_path).to eq(dashboard_path)
      
      click_link "Landing Page"

      click_link "Log Out"

      expect(page).to have_link("Log In")
      expect(page).to have_button("Create New User")
      expect(page).to_not have_link("Log Out")
    end
  end
end