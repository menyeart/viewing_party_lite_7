# frozen_string_literal: true

require "rails_helper"

RSpec.describe type: :feature do
  let!(:phil) { User.create!(name: "Phil", email: "philipjfry@gmail.com", password: 'password') }
  let!(:amy) { User.create!(name: "Amy", email: "amy_from_mars@gmail.com", password: 'password') }
  let!(:zoidberg) { User.create!(name: "Zoidberg", email: "dr_zoidberg_whoop_whoop_whoop_whoop@gmail.com", password: 'password') }

  describe "Landing Page" do
    before :each do
      visit root_path
    end

    context "When a user visits the landing page" do
      it "displays the title of the application" do
        expect(page).to have_content("Viewing Party")
      end

      it "displays a button to create a new user" do
        expect(page).to have_button("Create New User")
      end

      it "displays a link to go back to the landing page" do
        expect(page).to have_link("Landing Page")
        click_link "Landing Page"
        expect(current_path).to eq(root_path)
      end

      it "displays a link to for 'Log In" do
        expect(page).to have_link("Log In")
        click_link "Log In"
        expect(current_path).to eq(login_path)
        expect(page).to have_field("Email")
        expect(page).to have_field("Password")
        expect(page).to have_button("Log In")
      end
    end
  end
end
