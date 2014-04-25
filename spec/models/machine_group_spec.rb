require 'spec_helper'

describe MachineGroup do
  it { should belong_to(:manufacturer) }
  it { should have_many(:machines) }
  it { should have_many(:alarms).dependent(:destroy) }

  describe "#view_name" do
  	let(:group) { create(:machine_group) }

  	it "returns manufacturer+name+type+version" do
  		expect(group.view_name).to eq(group.manufacturer.name+ "-" +
											group.machine_type+"-"+group.version)
  	end
  end
  
end
