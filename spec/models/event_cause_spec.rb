require 'spec_helper'

describe EventCause do
  it { should belong_to(:service_event) }
  it { should have_many(:manifestations) }
  it { should have_many(:events).class_name('ServiceEvent').through(:manifestations) }
	it { should allow_mass_assignment_of(:name) }
end
