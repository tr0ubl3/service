FactoryGirl.define do
  factory :machine do
  	manufacturer_id 1
  	machine_owner_id 1
  	machine_number '9-1101-334'
  	machine_type 'CVA'
  	delivery_date '10.10.2010'
  	waranty_period '780'
  	display_name 'MH.329'
  	manufacturer
  	machine_owner
  end
end