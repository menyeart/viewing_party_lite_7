require 'rails_helper'

RSpec.describe ViewingParty, type: :model do
  describe "validations" do
    it { should validate_presence_of :date }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :duration }
    it { should validate_presence_of :movie_id }
    it { should validate_presence_of :host_id }
  end

  describe "relationships" do
    it { should have_many(:viewing_party_users) }
    it { should have_many(:users).through(:viewing_party_users) }
  end
end