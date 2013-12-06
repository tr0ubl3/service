class ServiceEvent < ActiveRecord::Base
  attr_accessible :machine_id, :event_date, :event_type, :event_description, :hour_counter, :event_name
  belongs_to :machine
  has_and_belongs_to_many :alarms
  belongs_to :user
  has_many :service_event_state_transitions
  accepts_nested_attributes_for :alarms

validates :machine_id, :presence => true
# validates :event_date, :presence => true
validates :hour_counter, :presence => true, :length => { :within => 3..6 },
						  numericality: { only_integer: true } 	
# validates :alarm_code, length: { is: 6 }, allow_nil: true, 
# 					   numericality: { only_integer: true }
validates :event_type, :presence => true
validates :event_description, :presence => true, :length => { :within => 3..500 }

state_machine :state, :initial => :event_created do
	store_audit_trail

	# state :event_created #event was created
	# state :pending_confirmation #event is waiting for confirmation
	# state :event_unconfirmed #event is uncofirmed because something is wrong
	# state :edit_unconfirmed_event #event is edited and then confirmed
	# state :event_finish_unconfirmed #event is stoped because it doesn't exist anymore
	# state :event_confirmed #event is confirmed by admin user
	# state :event_pending_waranty #event is pending waranty decision
	# state :event_waranty_true #event is a waranty case
	# state :event_waranty_false #event it's not a waranty case
	# state :event_waranty_false_pending_confirmation #event is waiting client confirmation
	# state :event_solving #event it's solving
	# state :pending_spare_parts #event to be solved needs spare parts
	# state :spare_parts_tracking #event is tracking spare parts
	# state :spare_parts_mounting #the spare parts are mounted
	# state :event_solved #the event has been solved
	# state :event_quotation #quotation of the event based on hours, parts, etc.
	# state :sending_quotation #sending quotation
	# state :event_closed #event has has ended

	# after_transition :on => :event_created, :do => :confirmation

	event :confirmation do
		transition :event_created => :pending_confirmation
	end

	event :confirmed do
		transition :pending_confirmation => :confirmed
	end

	event :unconfirmed do
		transition :uncofirmed => :revise_unconfirmed_event
	end

	event :false do
		transition :uncofirmed => :false_alarm
	end

	event :on_waranty do
		transition :confirmed => :event_solving
	end

	event :not_waranty do
		transition :confirmed => :pending_client_confirmation
	end

	event :event_confirmed_by_client do
		transition :pending_client_confirmation => :event_solving
	end

	# de facut event resolution and conclusion
	event :event_unconfirmed_by_client do
		transition :confirmed => :stop
	end

	event :event_solved do
		transition :event_solving => :event_solved
	end

	event :spare_parts_needed do
		transition :event_solved => :need_spare_parts
	end

	event :need_spare_parts_on_waranty do
		transition :need_spare_parts => :waranty_spare_parts_request
	end

	event :need_spare_parts_out_of_waranty do
		transition :need_spare_parts => :spare_parts_pending_client_confirmation
	end

	event :we_buy_parts do
		transition :spare_parts_pending_client_confirmation => :spare_parts_aquisition
	end

	event :waranty_spare_parts_tracking do
		transition [:waranty_spare_parts_request, :spare_parts_aquisition] => :spare_parts_tracking
	end

	event :self_aquisition_by_client do
		transition :need_spare_parts => :client_parts_aquiring
	end

	event :we_finish_intervention do
		transition :client_parts_aquiring => :spare_parts_mounting
	end

	event :we_do_not_finish_intervention do
		transition :spare_parts_pending_client_confirmation => :event_closed
	end

	event :spare_parts_arived do
		transition :spare_parts_tracking => :spare_parts_mounting
	end

	event :event_closing do
		transition :spare_parts_mounting => :event_conclusion
	end

	event :make_event_quotation do
		transition :event_conclusion => :event_quotation
	end

	event :closing_event do
		transition :event_quotation => :event_closed
	end
end

end
