class Credential < ActiveRecord::Base
  belongs_to :user
  
  attr_accessor :password, :service_password

  default_scope :order => 'credentials.created_at'
    
  validates :service, :presence => true, :length => { :maximum => 50 }
  validates :username, :presence => true, :length => { :maximum => 50 }
  validates :user_id, :presence => true
  validates :password, :presence     => true, :length => { :within => 6..40 }
                        
  validate :user_authentication

  private

  def user_authentication
    user = User.find(self.user_id)
    unless User.authenticate(user.username, self.password)
      errors.add(:password, "Your loboto.me password is incorrect.")
    end
  end

end
