FactoryGirl.define do
	factory :manufacturer do
	    sequence :id do |n|
			n + 200
	    end
	  	sequence :name do |n|
	  		"Manufacturer#{n}"
	  	end
	  	address "Str. Biel, No 1"
	  	office_tel "01234567891"
	  	office_mail "office@posalux1.com"
	  	country "Elvetia"
	  	city "Biel"
	  	postal_code "0079"
	  	fax "0123456789"
	  	mobile "0123456789"
	  	type "Manufacturer"

		factory :manufacturer_with_machines do
			ignore do
			  machines_count 5
			end
			after(:create) do |manufacturer, evaluator|
			  create_list(:machine, evaluator.machines_count, manufacturer: manufacturer)
			end
		end
	end
end