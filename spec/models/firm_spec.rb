require 'spec_helper'

describe Firm do
	it { should have_many(:users).dependent(:destroy) }

	describe "#machine_structure" do
		let!(:firm) { create(:authorized_reseller_with_machines) }
		let(:user) { create(:user, :firm_id => firm.id) }
	end
	
end