class Forum < ActiveRecord::Base
  attr_accessible :name, :user_id

  belongs_to :user
  has_many :conversations
  has_many :posts, :through => :conversations

  validates :name, presence: true
  validates :user_id, presence: true
end
