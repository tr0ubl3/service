class Alarm < ActiveRecord::Base
  attr_accessible :number, :text
  has_and_belongs_to_many :events
  
  # t1 = test 1
  scope :t1, lambda { |query| where(["number LIKE ?", "#{query}"]) }

	def self.seal(search_query)
		get_data(search_query)
		@g
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
