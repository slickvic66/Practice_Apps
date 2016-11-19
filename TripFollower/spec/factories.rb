FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "victor#{n}@example.com" }
    fname "victor"
    lname "oleinikov"
  end

  factory :trip do
    sequence(:name) {|n| "Family Vacation \##{n}" }
    sequence(:start_date) { |n| Date.new(2013,3,n) }
    user_id 1
  end

end