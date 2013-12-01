class AlarmStateTransition < ActiveRecord::Base
  belongs_to :alarm
  attr_accessible :created_at, :event, :from, :to
end
