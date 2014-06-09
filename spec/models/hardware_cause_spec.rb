require 'spec_helper'

describe HardwareCause do
  specify { HardwareCause.should be < EventCause }
	it { should allow_mass_assignment_of(:category) }
	it { should allow_mass_assignment_of(:problem) }
	it { should validate_uniqueness_of(:name).scoped_to(:problem) }
end
