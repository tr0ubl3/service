require 'spec_helper'

describe Machine do
	it { should belong_to(:machine_group) }
	it { should have_one(:manufacturer).through(:machine_group) }
	it { should belong_to(:machine_owner) }
	it { should belong_to(:authorized_reseller) }
	it { should have_many(:service_events) }
	it { should have_one(:hour_counter) }
end