require 'spec_helper'

describe Firm do
	it { should have_many(:users) }

	describe "#machine_structure" do
		let!(:firm) { create(:authorized_reseller_with_machines) }
		let(:user) { create(:user, :firm_id => firm.id) }
		
		it "returns a hash with manufacturer names" do
			machines_hash = Hash.new
			manufacturer_names = user.firm.machines.collect(&:manufacturer).collect(&:name).uniq
			machines_hash[:manufacturer_names] = {manufacturer_names.first => nil}
			expect(user.firm.machines_structure).to eq(machines_hash)
		end

		it "returns a hash with manufacturer names that have a hash with machine types" do
			machines_hash = Hash.new
			manufacturer_names = user.firm.machines.collect(&:manufacturer).collect(&:name).uniq
			machines_hash[:manufacturer_names] = {manufacturer_names.first => nil}
			machine_types = user.firm.machines.collect(&:machine_group).collect(&:name).uniq
			machines_hash[:manufacturer_names]["#{manufacturer_names.first}"] = {machine_types.first => nil}
			puts machines_hash
			expect(user.firm.machines_structure).to eq(machines_hash)
		end
	end
	
end