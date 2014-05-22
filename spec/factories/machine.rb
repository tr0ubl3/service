FactoryGirl.define do

  factory :machine do
  	sequence :id do |n|
      n
    end
  	machine_owner_id 201
    authorized_reseller_id 301

  	sequence :machine_number do |n|
      "9-1101-33#{n}"
    end
  	# machine_type 'CVA'
  	delivery_date '10.10.2010'
  	waranty_period '24'

    sequence :display_name do |n|
    	"MH.33#{n}"
    end
    hour_counter
    association :machine_group, factory: :machine_group_with_alarms, strategy: :build
    association :machine_owner, strategy: :build
  	association :authorized_reseller, strategy: :build
  end
end