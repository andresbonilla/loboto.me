class Credential < ActiveRecord::Base
  belongs_to :user
  
  attr_accessor :password, :service_password

  default_scope :order => 'credentials.created_at'
  
  before_save :symmetrically_encrypt_password
  
  validates :service, :presence => true, :length => { :maximum => 100 }
  validates :username, :presence => true, :length => { :maximum => 100 }
  validates :user_id, :presence => true
 
  validates :password, :presence     => true,
                       :length       => { :within => 6..40 }
                        

  private

  def symmetrically_encrypt_password
    self.salt = make_salt if new_record?
    key = secure_hash("#{self.salt}--#{password}")
    self.crypted_password = symmetrically_encrypt(service_password, key)
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::MD5.hexdigest(string)
  end
  
  def symmetrically_encrypt(string, key)
    "works till here"
  end

end
