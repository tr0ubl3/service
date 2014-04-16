class ServiceEvent < ActiveRecord::Base
	attr_accessible :user_id, :machine_id, :event_date, :event_type, :event_description,
	 				:hour_counter, :evaluation_description, :parent_event, :recurrent, 
  					:alarm_ids, :evaluator
  					
	belongs_to :machine
	has_and_belongs_to_many :alarms
	belongs_to :user
	has_many :states, class_name: "ServiceEventState"
	has_many :service_event_files, dependent: :destroy
	has_many :solving_steps
	accepts_nested_attributes_for :alarms, :allow_destroy => true
	# accepts_nested_attributes_for :service_event_files, :allow_destroy => true, :reject_if => :all_blank
	before_create :event_prepare
	after_create :opening

	STATES = %w[open evaluated solved] 
	delegate :open?, :evaluated?, :solved?, to: :current_state

	validates :machine_id, :presence => true
	# validates :event_date, :presence => true
	validates :hour_counter, :presence => true, :length => { :within => 3..6 },
							  numericality: { only_integer: true } 	
	validates :event_type, :presence => true
	validates :event_description, :presence => true, :length => { :within => 3..1000 }

	def self.query_state(state)
		joins(:states).merge ServiceEventState.with_last_state(state)
	end

	def current_state
		states.last.try(:state).inquiry	
	end	

	def opening
		states.create! state: "open"
	end

	def evaluate
		states.create! state: "evaluated" if open?
	end

	def solve
		states.create! state: "solved" if evaluated?
	end

	private
		def event_prepare
			self.event_name = assembly_name
		end

		def assembly_name
			machine = Machine.find(self.machine_id)
			owner = machine.machine_owner.name.upcase.first(limit=3)
			manufacturer = machine.manufacturer.name.upcase.first(limit=3)
			machine_number = machine.machine_number.gsub(/[-]/i, '')
			event_time = Time.now.strftime('%-d%-m%y%H%M')
			event_count = "%.5d" % (machine.service_events.count + 1)
			return manufacturer + '-'+ machine_number + '-' + event_time + '-' + event_count + '-' + owner
		end
end
