class Event < ActiveRecord::Base
  attr_accessible :machine_id, :event_date, :event_type, :event_description
  belongs_to :machine
end
