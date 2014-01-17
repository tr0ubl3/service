require 'spec_helper'

describe User do
	let(:user) { User.new }
	it 'is an ActiveRecord model' do
		expect(User.superclass).to eq(ActiveRecord::Base)
	end	

	it 'has_secure_password available' do
		user.password = 'testpassword'
		expect(user.password_digest).not_to be_nil
	end
	it 'has first_name' do
		user.first_name = "John"
		expect(user.first_name).to eq("John")
	end

	it 'has last_name' do
		user.last_name = "Wilkins"
		expect(user.last_name).to eq("Wilkins")
	end

	it 'has email' do
		user.email = "john.wilkins@mail.com"
		expect(user.email).to eq("john.wilkins@mail.com")
	end

	it 'has phone_number' do
		user.phone_number = 1234567890
		expect(user.phone_number).to eq(1234567890)
	end

	it 'responds to password' do
		user.password = "pass"
		expect(user.password).to eq("pass")
	end

	it "responds to password_confirmation" do
		user.password_confirmation = "pass"
		expect(user.password_confirmation).to eq("pass")
	end
end