require 'spec_helper'

describe Trip do

  subject(:trip)  { Trip.new(user_id: 1, name: "example trip", start_date: 1/1/2013) }

  it { should respond_to(:user_id) }
  it { should respond_to(:name) }
  it { should respond_to(:start_date) }
  it { should respond_to(:end_date) }
  it { should respond_to(:user) }

  it { should be_valid }

  context "user_id not provided" do
    before { trip.user_id = nil }
    it { should_not be_valid }
  end

  context "name is not provided" do
    before { trip.name = " " }
    it { should_not be_valid }
  end

  context "start date is not provided" do
    before { trip.start_date = nil }
    it { should_not be_valid }
  end

end
