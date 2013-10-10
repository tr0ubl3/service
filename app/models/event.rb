class Event < ActiveRecord::Base
  attr_accessible :machine_id, :event_date, :event_type, :event_description, :hour_counter, :alarm_code
  belongs_to :machine
  has_and_belongs_to_many :alarms
  
validates :machine_id, :presence => true
# validates :event_date, :presence => true
validates :hour_counter, :presence => true, :length => { :within => 3..6 },
						  numericality: { only_integer: true } 	
validates :alarm_code, length: { is: 6 }, allow_nil: true, 
					   numericality: { only_integer: true }
validates :event_type, :presence => true
validates :event_description, :presence => true, :length => { :within => 3..500 }

end
