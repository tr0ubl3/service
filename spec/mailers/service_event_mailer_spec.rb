require "spec_helper"

describe ServiceEvent do
  describe "open" do
	  	let!(:admin) { create(:admin) }
	  	let!(:event) { create(:service_event) }
		let(:email) { ServiceEventMailer.open(event) }

		#ensure that the subject is correct
		it 'renders the subject' do
			email.subject.should == "#{event.event_name} is open"
		end

		#ensure the receiver is correct
		it 'renders the receiver email' do
			admins = User.admins.collect(&:email).join(',')
			email.to.should == [admins]
		end

		#ensure the sender is correct
		it 'renders the sender mail' do
			email.from.should == ['service@internationalgt.ro']
		end

		#ensure that the first and last name appears in email body
		it 'assigns first and last name' do
			email.body.encoded.should have_content(event.event_name, event.user.full_name,
				event.machine.machine_owner.name)
		end
  end
  
end
