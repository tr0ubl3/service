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
  

  def self.owner_manufacturer_name(owner)
    # Manufacturer.where(:id => owner_manufacturer_ids(owner)).select(:name).map(&:name)
    Manufacturer.find(owner).name
  end

  def self.manufacturer_machine_types(manufacturer)
    Machine.where(:manufacturer_id => manufacturer).select(:machine_type).map(&:machine_type).map(&:upcase).uniq
  end

  def self.owner_machines_by_manufacturer_and_type(owner, manufacturer, type)
    Machine.where(:machine_owner_id => owner, :manufacturer_id => manufacturer, :machine_type => type)
  end

  def self.owner_manufacturer_ids(owner_id)
    Machine.where(:machine_owner_id => owner_id).select(:manufacturer_id).map(&:manufacturer_id).uniq
  end

  def waranty_boolean
    delivery_date + waranty_period.days > DateTime.now ? 'yes' : 'no'
  end

  def waranty_date
    delivery_date + waranty_period.days
  end

end
