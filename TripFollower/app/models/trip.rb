class Trip < ActiveRecord::Base
  attr_accessible :end_date, :name, :start_date, :user_id

  validates :user_id, presence: true
  validates :name, presence: true
  validates :start_date, presence: true

  belongs_to :user
  has_many :destinations

end
