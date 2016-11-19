require 'spec_helper'

describe User do

  subject(:user) { User.new( fname: "Example", lname: "User", email: "user@example.com" ) }

  it { should respond_to(:fname) }
  it { should respond_to(:lname) }
  it { should respond_to(:email) }
  it { should respond_to(:trips) }

  it { should be_valid }

  context "email is invalid" do
    it "should be invalid" do
      shitty_emails = %w[user@foo,com user_at_foo.org example.user@foo.
          foo@bar_baz.com foo@bar+baz.com ]
      shitty_emails.each do |shit|
        user.email = shit
        user.should_not be_valid
      end
    end
  end

  context "email is valid" do
    it "should be valid" do
      glorious_emails = %w[user@example.com user+something@example.com
        user_foo@example.com user.blah@co.uk]
      glorious_emails.each do |nice|
        user.email = nice
        user.should be_valid
      end
    end
  end

  context "without email" do
    before {user.email = " "}
    it { should_not be_valid }
  end

  context "when email not unique" do
    before do
      user.save
    end
    let(:user2) do
      user2 = user.dup  # YOU CANT PUT THE LET INSIDE A BEFORE
      user2.email.upcase!
      user2
    end
    specify { user2.should_not be_valid }
  end

  context "without first name" do
    before {user.fname = " "}
    it { should_not be_valid }
  end

  context "without last name " do
    before {user.lname = " "}
    it { should_not be_valid}
  end

end