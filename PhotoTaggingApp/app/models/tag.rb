class Tag < ActiveRecord::Base
  attr_accessible :name, :photo_id, :xcoord, :ycoord

  belongs_to :photo
end
