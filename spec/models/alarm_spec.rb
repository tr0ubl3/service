require 'spec_helper'

describe Alarm do
	it { should belong_to(:machine_group) }
end
