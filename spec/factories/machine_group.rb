FactoryGirl.define do
	factory :machine_group do
		machining_type "edm"
		machine_type "nozzle"
		sequence :version do |n|
			"V#{n}"
		end
		association :manufacturer, strategy: :build

		factory :machine_group_with_alarms do
			ignore do
			  alarms_count 5
			end

			after(:build) do |machine_group, evaluator|
			  create_list(:alarm, evaluator.alarms_count, machine_group: machine_group)
			end
		end
	end
end