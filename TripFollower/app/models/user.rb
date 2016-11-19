class User < ActiveRecord::Base
  attr_accessible :email, :fname, :lname, :password, :password_confirmation
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: {with: VALID_EMAIL_REGEX}
  validates :fname, presence: true
  validates :lname, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  before_save :create_remember_token

  has_many :trips

  private
  def create_remember_token
    self.token = SecureRandom.urlsafe_base64
  end
end
