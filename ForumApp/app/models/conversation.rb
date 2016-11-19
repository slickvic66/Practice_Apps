class Conversation < ActiveRecord::Base
  attr_accessible :forum_id, :name, :user_id, :posts_attributes

  belongs_to :user
  belongs_to :forum
  has_many :posts
  accepts_nested_attributes_for :posts

  validates :name, presence: true, uniqueness: { case_sensitive: false}
  validates :user_id, presence: true
end
