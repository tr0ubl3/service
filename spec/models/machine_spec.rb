require 'spec_helper'

describe Machine do
	it { should belong_to(:machine_group) }
	it { should have_one(:manufacturer).through(:machine_group) }
	it { should belong_to(:machine_owner) }
	it { should belong_to(:authorized_reseller) }
	it { should have_many(:service_events).dependent(:destroy) }
	it { should have_one(:hour_counter).dependent(:destroy) }

	describe "on save the authorized_reseller id is set on create of new record" do
		let!(:machine) { build(:machine, :authorized_reseller_id => nil) }
		
		it "authorized_reseller_id is saved before creation" do
			create(:authorized_reseller)
			machine.save!
			expect(machine.authorized_reseller_id).not_to be_nil
		end
	end
	
end