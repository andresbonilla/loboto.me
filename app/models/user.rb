class User < ActiveRecord::Base
  has_many :credentials, :dependent => :destroy
  
  attr_accessor :password
  
  attr_accessible :username, :password, :password_confirmation
  before_save :encrypt_password
  
  validates :username, :presence => true, 
                       :uniqueness => { :case_sensitive => false },
                       :length  => { :within => 4..50 }, 
                       :format   => { :with => /\A[a-zA-Z\d]{4,}\z/i }                      

  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }
  
  
  def has_password?(submitted_password)
    hashed_password == encrypt(submitted_password)
  end

  def self.authenticate(username, submitted_password)
    user = find_by_username(username)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  

  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.hashed_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::MD5.hexdigest(string)
  end

end
