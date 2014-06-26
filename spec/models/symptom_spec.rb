require 'spec_helper'

describe Symptom do
	it { should allow_mass_assignment_of(:number) }
	it { should allow_mass_assignment_of(:description) }
	it { should allow_mass_assignment_of(:machine_group_id) }
	it { should belong_to(:machine_group) }
	it { should have_many(:manifestations) }
	it { should have_many(:service_events).through(:manifestations) }
end
