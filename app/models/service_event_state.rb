class ServiceEventState < ActiveRecord::Base
  attr_accessible :state
  belongs_to :service_event

  def self.with_last_state(state)
  	order("id desc").group(self.column_names.collect {|c| "service_event_states.#{c}"}.join(",")).having(state: state)
  end
end
