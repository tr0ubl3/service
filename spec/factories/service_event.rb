FactoryGirl.define do
  factory :service_event do
  	  id 1
  	  machine_id 1
  	  event_date Time.now
  	  event_type 1
  	  event_description "Cannot start the machine"
  	  hour_counter "1000"
  	  event_name "POS-91231344-200214120809-00001-DEL"
  	  user_id 1
  	  state 'pending_confirmation'
  end
end