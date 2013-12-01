class ServiceEvent < ActiveRecord::Base
  attr_accessible :machine_id, :event_date, :event_type, :event_description, :hour_counter, :event_name
  belongs_to :machine
  has_and_belongs_to_many :alarms
  belongs_to :user
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

	event :confirmation do
		transition :event_created => :pending_confirmation
	end


end

end
