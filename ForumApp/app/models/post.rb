class Post < ActiveRecord::Base
  attr_accessible :body, :conversation_id, :user_id

  belongs_to :user, foreign_key: "user_id"
  belongs_to :conversation

  validates :body, presence: true
end
