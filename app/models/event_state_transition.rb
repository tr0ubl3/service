class EventStateTransition < ActiveRecord::Base
  belongs_to :event
  attr_accessible :created_at, :event, :from, :to
end
