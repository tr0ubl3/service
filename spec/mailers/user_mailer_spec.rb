require "spec_helper"

describe UserMailer do
  	describe 'confirmation' do
		let(:user) { mock_model(User, :first_name => "John", :last_name => "Wilkins",
		 			:email => "john_wilkins@firm.com", :admin => false) }
		let(:email) { UserMailer.confirmation(user) }

		#ensure that the subject is correct
		it 'renders the subject' do
			email.subject.should == 'Registration confirmation'
		end

		#ensure the receiver is correct
		it 'renders the receiver email' do
			email.to.should == [user.email]
		end

		#ensure the sender is correct
		it 'renders the sender mail' do
			email.from.should == ['noreply@service.com']
		end

		#ensure that the first and last name appears in email body
		it 'assigns first and last name' do
			email.body.encoded.should match(user.first_name + ' ' + user.last_name)
		end
	end

	describe 'approval' do
		let(:user) { mock_model(User, :first_name => "John", :last_name => "Wilkins",
		 			:email => "john_wilkins@firm.com", :admin => false) }
		let(:admin) { create(:admin) }
		let(:email) { UserMailer.approval([admin], user) }
		it 'renders the subject' do
			email.subject.should == 'Pending new user confirmation'
		end
		it 'renders the receiver name' do
			email.to.should == [admin.email]
		end
		it 'renders the sender email' do
			email.from.should == ['noreply@service.com']
		end
		it 'email opening' do
			email.body.encoded.should match('Registration of '+ user.first_name + ' ' + user.last_name)
		end

		it 'has user details link' do
			user_details_url = 'http://localhost:3000' + user_path(user.id)
			email.should have_body_text(/#{user_details_url}/)
		end
	end

	describe 'user_registration_approved' do
		let(:user) { create(:user2) }
		let(:email) { UserMailer.user_registration_approved(user) }

		it 'renders the subject' do
			email.subject.should == 'Your registration has been approved'
		end

		it 'renders the receiver email' do
			email.should deliver_to(user.email)
		end

		it 'renders the sender mail' do
			email.should deliver_from('noreply@service.com')
		end

		it 'assigns first and last name' do
			email.should have_body_text(/#{user.full_name}/)
		end
	end
end
