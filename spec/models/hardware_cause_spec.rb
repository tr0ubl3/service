require 'spec_helper'

describe HardwareCause do
  specify { HardwareCause.should be < EventCause }
	it { should allow_mass_assignment_of(:category) }
	it { should allow_mass_assignment_of(:problem) }
end
