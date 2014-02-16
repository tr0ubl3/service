require 'spec_helper'

describe User do
	let(:user) { User.new }

	describe 'validations' do
		before :each do
			@params = {
				firm_id: 1,
				first_name: 'Robb',
				last_name: 'Stark',
				phone_number: 0720123123,
				email: 'robb.stark@mail.com',
				password: 'securepassword',
				password_confirmation: 'securepassword', 
				admin: false
			}
		end
		it {should validate_presence_of :firm_id}
		it {should validate_presence_of :first_name}
		it {should ensure_length_of(:first_name).is_at_least(2).is_at_most(50)}
		it {should_not allow_value('Test234', 'Test 234', 'Test!234').for(:first_name)}
		it {should validate_presence_of :last_name}
		it {should ensure_length_of(:last_name).is_at_least(2).is_at_most(50)}
		it {should_not allow_value('Test234', 'Test 234', 'Test!234').for(:last_name)}
		it {should validate_presence_of :phone_number}
		it {should validate_numericality_of(:phone_number)}	
		it ' is invalid when phone number is too short' do
			@params[:phone_number] = 12345
			user = User.new(@params)
			expect(user.valid?).to be_false
		end
		it ' is invalid when phone number is too long' do
			@params[:phone_number] = SecureRandom.random_number(10*(10**25))
			user = User.new(@params)
			expect(user.valid?).to be_false
		end
		it {should validate_presence_of :email}
		it {should_not allow_value('user', 'user.mail').for(:email)}
		it {should validate_uniqueness_of(:email)}
		it {should validate_presence_of :password}
		it {should ensure_length_of(:password).is_at_least(6).is_at_most(255)}
		it {should validate_confirmation_of(:password)}
	end

	it 'is an ActiveRecord model' do
		expect(User.superclass).to eq(ActiveRecord::Base)
	end	

	it { should have_secure_password }
	it { should_not allow_mass_assignment_of(:password_digest) }
	it { should belong_to(:firm) }
	it { should have_many(:service_events) }

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

	it 'has approved_at attribute' do
		time = Time.now
		user.approved_at = time
		expect(user.approved_at).to eq(time)
	end

	it 'has approved_at attribute' do
		time = Time.now
		user.denied_at = time
		expect(user.denied_at).to eq(time)
	end

	it "has token attribute" do
		token = user.generate_token
		user.token = token
		expect(user.token).to eq(token)
	end

	it "has confirmed attribute" do
		expect(user.confirmed).to be_false
	end

	describe "#full_name" do
		let(:user) { create(:user) }
		it 'returns full name of a user' do
			expect(user.full_name).not_to be_nil 
		end
	end

	describe "#login_count_increment" do
		let(:user) { create(:user) }
		
		it 'increase user.login_count by 1' do
			expect{user.login_count_increment}.to change{user.login_count}.from(0).to(1)
		end
	end

	describe "#generate_token" do
		let(:user2) { build(:user2, token: nil) }
		it "generates a random string" do
			expect(user.generate_token.length).to eq(22)	
		end

		it "generates an unique token" do
			test_token = SecureRandom.urlsafe_base64(nil, false)
			# test_user = create(:user2, token: test_token)
			expect(user.generate_token).not_to eq(test_token)
		end

		it "saves token field on new user creation" do
			user2.save && user2.reload
			expect(user2.token).not_to be_empty
		end
	end
end