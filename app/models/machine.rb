class Machine < ActiveRecord::Base
  attr_accessible :manufacturer_id, :machine_owner_id, :machine_number, :machine_type, :delivery_date, :waranty_period, :display_name
  belongs_to :manufacturer
  belongs_to :machine_owner
  has_many :events
end
