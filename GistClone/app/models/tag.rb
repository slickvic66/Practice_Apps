class Tag < ActiveRecord::Base
  attr_accessible :body

  has_many :taggings, :dependent => :destroy
  has_many :gists, :through => :taggings

  validates :body, :presence => true
end
