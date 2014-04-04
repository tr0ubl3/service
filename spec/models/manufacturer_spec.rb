require 'spec_helper'

describe Manufacturer do
	it 'inherits from Firm model(SingleTableInheritance)' do
		expect(Manufacturer.superclass).to eq(Firm)
	end

	it { should have_many(:machine_groups) }	
end