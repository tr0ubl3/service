require 'spec_helper'

describe SolvingStep do
	 it { should validate_presence_of :step }
	 it { should belong_to(:service_event) }
	 it { should belong_to(:user) }
end
