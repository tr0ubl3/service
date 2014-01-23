require 'spec_helper'

describe Login do
	describe "#authenticate" do
		before :each do
			@user = create(:user)
		end
		it 'return user id if credentials are valid' do
			login = Login.new(email: 'bud.spencer@mail.com', password: 'securepassword')
			expect(login.conditional_authentication).to eq(1)
		end
		it 'return nil if email is not valid' do
			login = Login.new(email: 'test@mail.com', password: 'securepassword')
			expect(login.conditional_authentication).to eq(nil)
		end
		it 'returns nil if password is not valid' do
			login = Login.new(email: 'bud.spencer@mail.com', password: 'secure')
			expect(login.conditional_authentication).to eq(nil)
		end
		it 'returns nil when user registration is not approved' do
			@user.approved_at = nil
			@user.save
			login = Login.new(email: 'bud.spencer@mail.com', password: 'securepassword')
			expect(login.conditional_authentication).to eq(nil)
		end
	end
	context "attributes" do
		let(:login) {Login.new}

		it "has email" do
			login.email = "email@email.com"
			expect(login.email).to eq("email@email.com")
		end

		it "has password" do
			login.password = "securepassword"
			expect(login.password).to eq("securepassword")
		end
	end
end