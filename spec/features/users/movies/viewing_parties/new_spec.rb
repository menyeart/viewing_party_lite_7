require "rails_helper"
RSpec.describe "Viewing Party New Page" do
  let(:phil) { User.create!(name: "Philip", email: "philipjfry@gmail.com", password: "ilovejade") }

  describe "When I visit the movie details page", :vcr do
    before :each do
      visit user_discover_index_path(phil)
      click_button "Discover Top Rated Movies"
      click_link "The Godfather"
      click_button "Create Viewing Party"
    end

    # it "should see the name of the movie rendered above a form" do
    #   expect(page).to have_content("The Godfather")
    #   expect("The Godfather").to appear_before("Duration")
    # end

    # it "should have a form with fields to fill in viewing party attributes" do
    #   expect(page).to have_field("Duration")
    #   expect(page).to have_field("When")
    #   expect(page).to have_field("Start time")
    # end

    # it "should redirect to the user dashboard" do
    #   fill_in "Duration", with: "120"
    #   fill_in "When", with: "Feb 25"
    #   fill_in "Start time", with: "3:00pm"
    #   click_button "Create Party"

    #   expect(current_path).to eq(user_path(phil))
    # end

    # it "should remain on the same page and notify the user if invalid information is entered" do
    #   fill_in "Duration", with: ""
    #   fill_in "When", with: "Feb 25"
    #   fill_in "Start time", with: "3:00pm"
    #   click_button "Create Party"

    #   expect(page).to have_content("Duration can't be blank")
    # end
  end
end
