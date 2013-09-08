class Event < ActiveRecord::Base
  attr_accessible :machine_id, :event_date, :event_type, :event_description, :hour_counter, :alarm_code
  belongs_to :machine

validates :event_date, :presence => true
validates :hour_counter, :presence => true
validates :alarm_code, :presence => true
validates :event_type, :presence => true
validates :event_description, :presence => true
#   				   :length => { :within => 3..255 }
end
