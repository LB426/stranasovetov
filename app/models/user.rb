class User < ActiveRecord::Base
  
  attr_accessor :password
  before_save :encrypt_password
  
  #validates_confirmation_of :password
  #validates_presence_of :password, :on => :create
  #validates_presence_of :login
  #validates_uniqueness_of :login
  validates :login, length: { minimum: 4 }
  validates :login, presence: true
  validates :login, uniqueness: true
  validates :password, length: { minimum: 6 }, :on => :create
  validates :password, presence: true, :on => :create
  
  def self.authenticate(login, password)
    user = find_by_login(login)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end	
end
