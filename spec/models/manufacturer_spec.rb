require 'spec_helper'

describe Manufacturer do
	it 'inherits from Firm model(SingleTableInheritance)' do
		expect(Manufacturer.superclass).to eq(Firm)
	end

	it { should have_many(:machine_groups).dependent(:destroy) }
	it { should have_many(:machines).through(:machine_groups) }
end