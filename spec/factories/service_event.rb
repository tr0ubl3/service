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
      alarms {[FactoryGirl.create(:alarm)]}
  	  # state 'open'
      association :machine, strategy: :build
      association :user, strategy: :build
  end

  factory :service_event_with_alarms, :parent => :service_event do
    alarms {FactoryGirl.create_list(:alarm, 5)}
  end
end