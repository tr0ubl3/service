require 'spec_helper'

describe EventCause do
  it { should belong_to(:service_event) }
	it { should allow_mass_assignment_of(:name) }
end
