require "rails_helper"

RSpec.describe type: :feature do
  let!(:phil) { User.create!(name: "Phil", email: "philipjfry@gmail.com", password: "pizzabeer") }
  let!(:amy) { User.create!(name: "Amy", email: "amy_from_mars@gmail.com", password: "ilovemars") }
  let!(:zoidberg) { User.create!(name: "Zoidberg", email: "dr_zoidberg_whoop_whoop_whoop_whoop@gmail.com", password: "whoopwhoop") }

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

      # it "displays a list of existing users as a link" do
      #   expect(page).to have_link(phil.name.to_s)
      #   expect(page).to have_link(amy.name.to_s)
      #   expect(page).to have_link(zoidberg.name.to_s)
      # end

      # it "when I click a user link I am taken to the users dashboard" do
      #   click_link "Phil"

      #   expect(current_path).to eq(user_path(phil))
      # end

      # it "displays a link to go back to the landing page" do
      #   expect(page).to have_link("Landing Page")
      #   click_link "Landing Page"
      #   expect(current_path).to eq(root_path)
      # end
      
      it "displays a list of existing users emails" do
        expect(page).to have_content("philipjfry@gmail.com")
        expect(page).to have_content("amy_from_mars@gmail.com")
        expect(page).to have_content("dr_zoidberg_whoop_whoop_whoop_whoop@gmail.com")
      end

      it "will not let you visit the dashboard without being logged in" do
        visit user_path(phil)

        expect(current_path).to eq(root_path)
        expect(page).to have_content("You must be logged in to access your dashboard.")
      end
    end
  end
end
