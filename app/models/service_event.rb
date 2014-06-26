class ServiceEvent < ActiveRecord::Base
	attr_accessible :user_id, :machine_id, :event_date, :event_type, 
									:event_description, :hour_counter, :evaluation_description,
									:evaluator, :alarm_ids, :cause_tokens
	attr_reader :cause_tokens
  					
	belongs_to :machine
	belongs_to :user
	has_many :manifestations
	has_many :symptoms, through: :manifestations
	has_many :causes, class_name: 'EventCause', through: :manifestations
	has_many :states, class_name: 'ServiceEventState', dependent: :destroy
	has_many :files, class_name: 'ServiceEventFile', dependent: :destroy, validate: false
	has_many :solving_steps, dependent: :destroy
	

	accepts_nested_attributes_for :causes, allow_destroy: true

	before_create :event_prepare
	after_create :opening

	STATES = %w[open evaluated solved closed] 
	delegate :open?, :evaluated?, :solved?, :closed?, to: :current_state

	validates :machine_id, :presence => true
	validates :event_date, :presence => true
	validates :hour_counter, :presence => true, :length => { :within => 3..6 },
							  numericality: { only_integer: true } 	
	validates :event_type, :presence => true
	# validates :event_description, :presence => true, :length => { :within => 3..1000 }
	# validates :evaluation_description, :presence => true, :length => { :within => 3..1000 }

	def self.query_state(state)
		joins(:states).merge ServiceEventState.with_last_state(state)
	end

	def current_state
		states.last.try(:state).inquiry	
	end	

	def opening
		states.create! state: "open"
		# ServiceEventMailer.open(self).deliver
	end

	def evaluate
		states.create! state: "evaluated" if open?
	end

	def solve
		states.create! state: "solved" if evaluated?
		# call close state until
		close
	end

	def close
		states.create! state: "closed" if solved?
		# ServiceEventMailer.close(self).deliver
	end

	def cause_tokens=(tokens)
		self.cause_ids = causes.ids_from_tokens(tokens)
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
			event_time = Time.now.strftime('%d%m%y')
			event_count = "%.2d" % (machine.service_events.count + 1)
			return manufacturer + '-'+ machine_number + '-' + event_count + '-' + owner
		end
end
