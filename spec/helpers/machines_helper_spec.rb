require 'spec_helper'

describe MachinesHelper do
	describe "#waranty_boolean" do
		let!(:machine) { create(:machine) }

		it "returns yes or no if machine is(not) in waranty period" do
			expect(helper.waranty_boolean(machine)).to eq('yes')
		end
	end
end