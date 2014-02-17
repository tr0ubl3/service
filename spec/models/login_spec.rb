require 'spec_helper'

describe Login do
	describe "#conditional_authentication" do
		let!(:user) { create(:user, confirmed: false) }

		before :each do
			@login = Login.new(email: user.email, password: user.password)
		end

		it 'return user_id if credentials are valid' do
			expect(@login.conditional_authentication).to eq(1)
		end

		it 'return nil if email is not valid' do
			@login2 = Login.new(email: "email@email.com", password: "testpassword")
			expect(@login2.conditional_authentication).to be_nil
		end

		it 'returns nil if password is not valid' do
			@login2 = Login.new(email: user.email, password: "testpassword2")
			expect(@login2.conditional_authentication).to be_nil
		end

		it 'returns nil when user registration is not approved' do
			user.update_attribute(:approved_at, nil) && user.reload
			new_login = Login.new(email: user.email, password: user.password)
			expect(new_login.conditional_authentication).to be_nil
		end

		it "returns nil when user has not confirmed the email" do
			expect(@login.conditional_authentication).to be_nil
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