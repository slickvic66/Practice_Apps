class User < ActiveRecord::Base
  attr_accessible(:user_name, :password, :password_confirmation,
    :password_digest, :session_token, :email)

  has_many :secrets, :dependent => :destroy
  has_many :shares
  has_many :friends, :through => :shares
  has_secure_password

  validates :password, :length => {:in => 4..20,
      :too_long => " is too long, you will never remember it damn you!",
      :too_short => " is too short damn you!"},
      :if => :with_password?
  validates :user_name, :uniqueness => true, :presence => true
  validates :email, :format =>  /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/

  def with_password?
    self.password == false
  end

end
