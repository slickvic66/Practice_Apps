class User < ActiveRecord::Base
  attr_accessible :user_name

  has_many :gists
  has_many :files, :through => :gists
  has_many :favorites

  validates :user_name, :uniqueness => true, :presence => true
end
