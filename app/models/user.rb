class User < ActiveRecord::Base
 
  has_secure_password
  # attr_accessor :password, :password_confirmation
  attr_accessible :email, :machine_owner_id, :first_name, :last_name,
                  :phone_number, :remember_me, :admin, :password, :password_confirmation
  belongs_to :machine_owner
  has_many :service_events
  
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  NAME_REGEX = /\A[A-Z]+\z/i

  validates :machine_owner_id, :presence => true
  validates :first_name, :presence => true,
                :length => { :within => 3..255, message: 'missing required length' },
                :format => { with: NAME_REGEX }
  validates :last_name, :presence => true,
                :length => { :within => 3..255, message: 'missing required length' },
                :format => { with: NAME_REGEX }
  validates :phone_number, :presence => true,
                :length => { :within => 3..255, message: 'missing required length' },
                :uniqueness => true, numericality: {:only_integer => true}
  validates :email, :length => { :within => 3..255, message: 'missing required length' },
                    :format => { with: EMAIL_REGEX, 
                                 message: 'must be formated correctly'},
                    :uniqueness => true                            

  def full_name
  	first_name + " " + last_name
  end
end
