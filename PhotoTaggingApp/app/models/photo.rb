class Photo < ActiveRecord::Base
  attr_accessible :url

  has_many :tags
end
