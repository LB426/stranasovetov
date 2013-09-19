class User < ActiveRecord::Base
  has_many :publications

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
  
  has_attached_file :avatar, 
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :path => ":rails_root/public/images/avatars/:id/:style/:basename.:extension",
                    :url  => "/images/avatars/:id/:style/:basename.:extension",
                    :default_url => "/images/avatar-missing.png"

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
