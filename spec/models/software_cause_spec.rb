require 'spec_helper'

describe SoftwareCause do
  specify { SoftwareCause.should be < EventCause }
	it { should allow_mass_assignment_of(:problem_description) }
	it { should_not allow_mass_assignment_of(:category) }
	it { should_not allow_mass_assignment_of(:problem) }
end
