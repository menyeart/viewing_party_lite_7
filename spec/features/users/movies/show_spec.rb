require "rails_helper"
RSpec.describe type: :feature do
  describe "Movie Details Page", :vcr do
    let(:phil) { User.create!(name: "Philip", email: "philipjfry@gmail.com", password: "iloveclimbing") }

    describe "When I visit the movie details page" do
      before :each do
        visit user_discover_index_path(phil)
        click_button "Discover Top Rated Movies"
        click_link "The Godfather"
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(phil)
      end

      it "displays a button to create a new viewing party" do
        expect(current_path).to eq("/users/#{phil.id}/movies/238")
        expect(page).to have_button("Create Viewing Party")

        click_button "Create Viewing Party"

        expect(current_path).to eq("/users/#{phil.id}/movies/238/viewing_party/new")
      end

      it "displays a button to return to the discover page" do
        expect(page).to have_button("Discover Movies")

        click_button "Discover Movies"

        expect(current_path).to eq(user_discover_index_path(phil))
      end

      it "displays the movie's attributes" do
        expect(page).to have_content("Title: The Godfather")
        expect(page).to have_content("Movie Summary: Spanning the years 1945 to 1955,")
        expect(page).to have_content("Vote Average: 8.711")
        expect(page).to have_content("Runtime: 175 min")
        expect(page).to have_content("Crime")
      end

      it "displays the first 10 cast memebers of the movie" do
        expect(page).to have_content("Marlon Brando")
        expect(page).to have_content("Al Pacino")
        expect(page).to have_content("James Caan")
        expect(page).to have_content("Robert Duvall")
        expect(page).to have_content("Diane Keaton")
        expect(page).to have_content("Talia Shire")
        expect(page).to have_content("Gianni Russo")
        expect(page).to have_content("Sterling Hayden")
        expect(page).to have_content("Al Lettieri")
        expect(page).to have_content("Richard S. Castellano")
      end

      it "displays the total count of reviews with each reviews author and information" do
        expect(page).to have_content("futuretv")
        expect(page).to have_content("crastana")
        expect(page).to have_content("James Caan")
        expect(page).to have_content("Total Count of Reviews: 3")
      end
    end
  end

  describe "When A user is not logged in" do
    let(:phil) { User.create!(name: "Philip", email: "philipjfry@gmail.com", password: "iloveclimbing") }

    it "does not let me create a viewing party if I am not logged in" do
      VCR.use_cassette("movie_details") do
        visit user_discover_index_path(phil)
        click_button "Discover Top Rated Movies"
        click_link "The Godfather"
        click_on "Create Viewing Party"
        
        expect(current_path).to eq(user_movie_path(phil, 238))
        expect(page).to have_content("You must be logged in or register to continue.")
      end
    end
  end
end
