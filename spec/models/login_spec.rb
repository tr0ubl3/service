require 'spec_helper'

describe Login do
	describe "authenticate" do
		before :each do
			create(:user)
		end
		it 'return user id if credentials are valid' do
			login = Login.new(email: 'bud.spencer@mail.com', password: 'securepassword')
			expect(login.authenticate).to eq(1)
		end
		it 'return nil if email is not valid' do
			login = Login.new(email: 'test@mail.com', password: 'securepassword')
			expect(login.authenticate).to eq(nil)
		end
		it 'returns nil if password is not valid' do
			login = Login.new(email: 'bud.spencer@mail.com', password: 'secure')
			expect(login.authenticate).to eq(nil)
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