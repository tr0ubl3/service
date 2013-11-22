class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :machine_owner_id, :first_name, :last_name, :phone_number, :remember_me
  belongs_to :machine_owner
  has_many :events

  def full_name
  	first_name + " " + last_name
  end

end
