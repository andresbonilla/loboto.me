class Credential < ActiveRecord::Base
  belongs_to :user
  
  default_scope :order => 'credentials.created_at'
  
  validates :service, :presence => true, :length => { :maximum => 100 }
  validates :username, :presence => true, :length => { :maximum => 100 }
  validates :user_id, :presence => true
 
  # validates :password, :presence     => true,
  #                      :confirmation => true,
  #                      :length       => { :maximum =>100 }
                        
end
