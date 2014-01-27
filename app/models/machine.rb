class Machine < ActiveRecord::Base
  attr_accessible :manufacturer_id, :machine_owner_id, :machine_number, :machine_type, :delivery_date, :waranty_period, :display_name
  belongs_to :manufacturer
  belongs_to :machine_owner
  has_many :service_events
  has_one :hour_counter
  
  validates :display_name, :presence => true,
    				   :length => { :within => 3..255 },
    				   :uniqueness => true
  validates :machine_number, :presence => true,
    				      :length => { :within => 3..255 },
    				      :uniqueness => true

  validates :machine_type, :presence => true,
  				      :length => { :within => 3..255 }

  validates :delivery_date, :presence => true,
  				      :length => { :within => 3..255 }

  validates :waranty_period, :presence => true,
  				      :length => { :within => 3..255 }
  

  def waranty_boolean
    delivery_date + waranty_period.days > DateTime.now ? 'yes' : 'no'
  end

  def waranty_date
    delivery_date + waranty_period.days
  end

end
