class User < ActiveRecord::Base
  has_secure_password
  attr_accessor :current_password
  attr_accessible :email, :firm_id, :first_name, :last_name,
                  :phone_number, :admin, :password, :password_confirmation, :approved_at,
                  :denied_at, :password_reset_token, :password_reset_sent_at, :current_password
  belongs_to :firm
  has_many :service_events
  has_many :solving_steps
  has_many :created_users, class_name: 'User', foreign_key: 'admin_id'
  belongs_to :admin_user, class_name: 'User', foreign_key: 'admin_id'
  before_create { generate_token(:auth_token) }

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  NAME_REGEX = /^\A([A-Z']+-?+[A-Z']+\z)+$/i

  validates :firm_id, :presence => true
  validates :first_name, :presence => true,
                :length => { :within => 2..50 },
                :format => { with: NAME_REGEX }
  validates :last_name, :presence => true,
                :length => { :within => 2..50 },
                :format => { with: NAME_REGEX }
  validates :phone_number, :presence => true,
                :length => { :within => 6..25 },
                numericality: {:only_integer => true}
  validates :email, :presence => true,
                    :format => { with: EMAIL_REGEX},
                    :uniqueness => true
  validates :password, :presence => true,
                       :length => { :within => 6..255 }
  
  scope :admins, -> { where(admin: true) } 

  def full_name
  	first_name + " " + last_name
  end

  def login_count_increment
    self.increment!(:login_count)
  end

  def generate_token(column)
    self[column] = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(column => random_token)
    end
  end
end
