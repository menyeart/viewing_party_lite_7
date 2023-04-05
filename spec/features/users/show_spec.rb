# frozen_string_literal: true

require "rails_helper"

RSpec.describe type: :feature do
  let!(:phil) { User.create!(name: "Philip", email: "philipjfry@gmail.com", password: "ilovejade") }
  let!(:amy) { User.create!(name: "Amy", email: "amy_from_mars@gmail.com", password: "imfrommars") }

  Timecop.freeze(Time.now)
  let!(:spirited_away) { ViewingParty.create!(date: "05/28/2023", start_time: Time.now, duration: 2, movie_id: 1, host_id: amy.id) }
  describe "User dashboard" do
    before :each do
      ViewingPartyUser.create!(user_id: phil.id, viewing_party_id: spirited_away.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(phil)
      visit user_path(phil)
    end

    describe "As a visitor" do
      it "displays the appropriate users name" do
        expect(page).to have_content("Philip's Dashboard")
        expect(page).to_not have_content("Amy's Dashboard")
      end

      it "displays a button to discover movies" do
        expect(page).to have_button("Discover Movies")
      end

      it "displays a section that lists viewing parties" do
        expect(page).to have_content("Viewing Parties:")
        expect(page).to have_content("Movie id: #{spirited_away.movie_id}")
        expect(page).to have_content("Date: #{spirited_away.date}")
        expect(page).to have_content("Start time: #{spirited_away.start_time.strftime('%I:%M')}")
        expect(page).to have_content("Duration: #{spirited_away.duration}")
        # add to this with viewing parties issue
      end
    end
  end
end
