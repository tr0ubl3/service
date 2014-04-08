require 'spec_helper'

describe MachineGroupsHelper do
	describe "#group_name" do
		let(:group) { create(:machine_group) }
	  
		it "returns manufacturer+name+type+version " do
			expect(helper.group_name(group)).to eq(group.manufacturer.name+ "-" +
											group.machine_type+"-"+group.version)
		end
	end
end
