require 'spec_helper'

describe "Trips" do
  before(:each) {visit path}
  subject { page }

  context "new trip" do
    let(:user) {FactoryGirl.create(:user)}
    let(:path) {new_trip_path(:user_id => user.id)}

    it {source.should have_selector('title', text: "New Trip")}
    it {should have_selector('h1', text: "Create New Trip")}

    context "with incorrect information" do

      before(:each) {visit path}

      it "fails to create a new trip" do
        expect { click_button "Submit" }.not_to change(Trip, :count)
      end

    end

    context "with correct information" do
      before(:each) do
        visit path
        fill_in "Trip Name", with: "Howdy do"
        fill_in "trip_start_date", with: "08/01/2012"
        fill_in "trip_end_date", with: "08/02/2012"
      end

      it "should increase the trip count by one" do
        expect { click_button "Submit" }.to change(Trip, :count).by(1)
      end
    end
  end
end
