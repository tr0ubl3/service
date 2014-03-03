FactoryGirl.define do
	factory :hour_counter do
		sequence :machine_id do |n|
			n
		end
		machine_hours_age 1000
	end
end