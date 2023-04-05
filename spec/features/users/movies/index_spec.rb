require "rails_helper"

RSpec.describe "Discover Movies Page" do
  let!(:zoidberg) { User.create!(name: "Zoidberg", email: "doc_z_berg@gmail.com", password: "drz_berg23") }
  describe "Top 20 Movies", :vcr do
    it "should be able to click on top movies button and be redirected to the movies result page" do
      visit "/users/#{zoidberg.id}/discover"

      click_button("Discover Top Rated Movies")

      expect(current_path).to eq(user_movies_path(zoidberg))
    end

    it "where a maximum of 20 results are displayed with their respective titles and vote average" do
      visit user_movies_path(zoidberg)

      expect(page).to have_content("Title", count: 20)
      expect(page).to have_content("Vote Average", count: 20)
      expect(page).to have_link("The Godfather")
      expect(page).to have_link("12 Angry Men")
    end

    it "displays button to go back to the discover page" do
      visit user_movies_path(zoidberg)

      expect(page).to have_button("Discover Page")
      click_button "Discover Page"

      expect(current_path).to eq("/users/#{zoidberg.id}/discover")
    end
  end

  describe "Movie Keyword Search", :vcr do
    it "can search for movies by keyword" do
      visit "/users/#{zoidberg.id}/discover"

      fill_in "Title", with: "The Godfather"
      click_button("Find Movies")

      expect(current_path).to eq(user_movies_path(zoidberg))
      expect(page).to have_link("The Godfather")
      expect(page).to have_link("The Godfather Part II")
      expect(page).to_not have_link("12 Angry Men")
    end
  end
end
