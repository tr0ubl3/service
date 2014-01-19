require 'spec_helper'

describe User do
	let(:user) { User.new }

	describe 'validations' do
		before :each do
			@params = {
				machine_owner_id: '1',
				first_name: 'Robb',
				last_name: 'Stark',
				phone_number: '0720123123',
				email: 'robb.stark@mail.com',
				password: 'securepassword',
				password_confirmation: 'securepassword', 
				admin: false
			}
		end
		it 'is invalid machine owner id is empty' do
			@params[:machine_owner_id] = nil
			user = User.new(@params)
			expect(user.valid?).to be_false
		end
		it 'is invalid when first name is empty' do
			@params[:first_name] = nil
			user = User.new(@params)
			expect(user.valid?).to be_false
		end
		it 'is invalid when first name is invalid' do
			@params[:first_name] = 'Test312'
			user = User.new(@params)
			expect(user.valid?).to be_false
		end
		it 'is invalid when last name is empty' do
			@params[:last_name] = nil
			user = User.new(@params)
			expect(user.valid?).to be_false
		end
		it 'is invalid when phone number is empty' do
			@params[:phone_number] = nil
			user = User.new(@params)
			expect(user.valid?).to be_false
		end
		it 'is invalid email is invalid' do
			@params[:email] = 'robb'
			user = User.new(@params)
			expect(user.valid?).to be_false
		end
		it 'is invalid when email is not unique' do
			User.create(@params)
			user = User.new(@params)
			expect(user.valid?).to be_false
		end
		it 'is invalid when password and password confirmation are not the same' do
			@params[:password] = 'secure'
			user = User.new(@params)
			expect(user.valid?).to be_false
		end
	end

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