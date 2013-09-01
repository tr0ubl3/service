class Event < ActiveRecord::Base
  attr_accessible :machine_id, :event_date, :event_type, :event_description, :hour_counter
  belongs_to :machine

validates :event_date, :presence => true
validates :event_type, :presence => true
validates :event_description, :presence => true,
  				   :length => { :within => 3..255 }
end
