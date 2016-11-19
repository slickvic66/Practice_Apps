require 'spec_helper'

describe "User Pages" do

  subject { page }

  describe "index" do
    before(:all) { 5.times { FactoryGirl.create(:user) } }
    after(:all) { User.delete_all }
    let(:users) { User.all }
    before(:each) {visit users_path}

    it { source.should have_selector('title', text: 'Users') }
    it { should have_selector('h1', text: 'Users') }

    it "should list each user" do
      users.each do |user|
        page.should have_selector('li', text: user.email)
      end
    end

  end

  describe "show" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      5.times { FactoryGirl.create(:trip, user_id: user.id) }
      visit user_path(user.id)
    end

    it "should show all the user's trips" do
      user.trips.each do |trip|
        page.should have_selector("li##{trip.id}", text: trip.name )
      end
    end

  end

  describe "new user page" do
    before(:each) { visit new_user_path }
    it { source.should have_selector('title', text: 'Signup') }
    it { should have_selector('h1', text: 'Signup') }

    describe "with incorrect information" do
      it "should not create a user" do
        expect { click_button "submit" }.not_to change(User, :count)
      end
    end

    describe "with correct info" do
      let(:user) { FactoryGirl.attributes_for(:user) }
      before(:each) do
        fill_in "First Name", with: user[:fname]
        fill_in "Last Name", with: user[:lname]
        fill_in "Email", with: user[:email]
      end

      it "should create a new user" do
        expect{click_button "submit"}.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before(:each) { click_button "submit" }

        it { should have_selector('h1', user[:fname])}
        it { should have_selector('div.alert.alert-success', text: "Welcome")}

      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) { visit edit_user_path(user) }

    describe "has prefilled values" do
      specify {find_field('First Name').value.should eq(user.fname)}
      specify {find_field('Last Name').value.should eq(user.lname)}
      specify {find_field('Email').value.should eq(user.email)}
    end

    describe "submission of valid information" do

      let(:new_fname) { "NEWNAME" }
      before(:each) do
        fill_in "First Name", with: new_fname
        click_button "submit"
      end

      it "has the updated values in the database" do
        user.reload.fname.should eq(new_fname)
      end
      it { should have_selector('div.alert.alert-success', text: "successful")}

    end

  end

end
