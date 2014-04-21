FactoryGirl.define do
	factory :machine_group do
		machining_type "edm"
		machine_type "nozzle"
		version "V5"
		association :manufacturer, strategy: :build
	end
end