class Alarm < ActiveRecord::Base
  attr_accessible :number, :text
  has_and_belongs_to_many :service_events
  
  # t1 = test 1
  scope :t1, lambda { |query| where(["number = ?", "#{query}".to_i]) }

	def self.seal(search_query)
		get_data(search_query)
		@g
	end

	state_machine :state, :initial => :alarm_created do
		store_audit_trail
		
		event :confirmation do
			transition :alarm_created => :alarm_pending
		end
	end

private
	def self.get_data(eval)
		e = t1(eval)
		@g = nil 
		if e.length == 1
			e.each do |e|
				@g = e.text
			end
		end
	end
end
