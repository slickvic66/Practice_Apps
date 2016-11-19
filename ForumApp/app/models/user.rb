class User < ActiveRecord::Base
  attr_accessible :email, :name
  has_many :forums
  has_many :conversations
  has_many :posts, foreign_key: "user_id"

  validates :name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
end
