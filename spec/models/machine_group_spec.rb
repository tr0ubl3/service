require 'spec_helper'

describe MachineGroup do
  it { should belong_to(:manufacturer) }
  it { should have_many(:machines).dependent(:destroy) }
  it { should have_many(:alarms).dependent(:destroy) }

  it { should validate_presence_of(:manufacturer_id) }
  it { should validate_presence_of(:machining_type) }
  it { should validate_presence_of(:machine_type) }
  it { should validate_presence_of(:version) }
  it { should validate_uniqueness_of(:machine_type) }
  it { should validate_uniqueness_of(:version) }

  describe "#view_name" do
  	let(:group) { create(:machine_group) }

  	it "returns manufacturer+name+type+version" do
  		expect(group.view_name).to eq(group.manufacturer.name+ "-" +
											group.machine_type+"-"+group.version)
  	end
  end
  
end
