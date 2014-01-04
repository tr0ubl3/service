class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation,
                  :machine_owner_id, :first_name, :last_name,
                  :phone_number, :remember_me
  belongs_to :machine_owner
  has_many :service_events
  
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  
  validates :first_name, :presence => true,
                :length => { :within => 3..255, message: 'missing required length' }
  validates :last_name, :presence => true,
                :length => { :within => 3..255, message: 'missing required length' }
  validates :phone_number, :presence => true,
                :length => { :within => 3..255, message: 'missing required length' },
                :uniqueness => true
  validates :email, :length => { :within => 3..255, message: 'missing required length' },
                    :format => { with: EMAIL_REGEX, 
                                 message: 'must be formated correctly'},
                    :uniqueness => true                            

  def full_name
  	first_name + " " + last_name
  end
end
