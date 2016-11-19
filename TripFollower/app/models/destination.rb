class Destination < ActiveRecord::Base
  attr_accessible :name, :location, :image, :thoughts, :trip_id
  validates :trip_id, presence: true
  validates :name, presence: true

  belongs_to :trip
end