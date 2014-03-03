FactoryGirl.define do
	factory :machine_owner do
	    id 201
	  	name "Delphi"
	  	address "Str. Victoria, No. 10"
	  	office_tel "0123456789"
	  	office_mail "office@delphi.com"
	  	country "Romania"
	  	city "Nowhere"
	  	postal_code "700123"
	  	fax "0123456789"
	  	mobile "0123456789"
	  	type "MachineOwner"

		factory :machine_owner_with_machines do
			ignore do
			  machines_count 5
			end
			after(:create) do |machine_owner, evaluator|
			  create_list(:machine, evaluator.machines_count, machine_owner: machine_owner)
			end
		end
	end
end