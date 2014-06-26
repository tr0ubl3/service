require 'spec_helper'

describe ServiceEvent do
	let(:event) { ServiceEvent.new }

	describe "validations" do
		before :each do
			@params = {
				event_date: "01.01.1900",
				hour_counter: "1234",
				event_type: "1",
				event_description: "machine has alarm 700123"
			}
		end

		it {should validate_presence_of :machine_id}
		it {should validate_presence_of :hour_counter}
		it {should validate_presence_of :event_type}
		it {should validate_presence_of :event_dates}
		it {should_not validate_presence_of :event_description}
		it {should ensure_length_of(:event_description).is_at_least(3).is_at_most(1000)}
		it {should validate_numericality_of(:hour_counter)}
		# it {should validate_presence_of :evaluation_description}
	end

	it 'is an ActiveRecord model' do
		expect(ServiceEvent.superclass).to eq(ActiveRecord::Base)
	end

	it 'has machine_id' do
		event.machine_id = 1
		expect(event.machine_id).to eq(1)
	end

	it 'has event_date' do
		event.event_date = '01.01.1900'
		expect(event.event_date.strftime('%d.%m.%Y')).to eq('01.01.1900')		
	end

	it 'has event_type' do
		event.event_type = 1
		expect(event.event_type).to eq(1)
	end

	it 'has event_description' do
		event.event_description = 'Machine stopped with alarm 700123'
		expect(event.event_description).to eq('Machine stopped with alarm 700123')
	end

	it 'has hour_counter' do
		event.hour_counter = 1234
		expect(event.hour_counter).to eq(1234)
	end

	it "has evaluator" do
		user = create(:user)
		event.evaluator = user.id
		expect(event.evaluator).to eq(user.id)
	end
	
	it { should allow_mass_assignment_of(:machine_id) }
	it { should allow_mass_assignment_of(:event_date) }
	it { should allow_mass_assignment_of(:event_type) }
	it { should allow_mass_assignment_of(:event_description) }
	it { should allow_mass_assignment_of(:hour_counter) }
	it { should_not allow_mass_assignment_of(:service_event_files_attributes) }
	it { should allow_mass_assignment_of(:alarm_ids) }
	it { should allow_mass_assignment_of(:evaluator) }
	it { should allow_mass_assignment_of(:causes_ids) }
	
	it { should_not allow_mass_assignment_of(:event_name) }
	it { should belong_to(:machine) }
	it { should belong_to(:user) }
	it { should have_many(:states).class_name('ServiceEventState').dependent(:destroy) }
	it { should have_many(:solving_steps).dependent(:destroy) }
	it { should have_many(:manifestations) }
	it { should have_many(:symptoms).through(:manifestations) }
	it { should have_many(:service_event_files).dependent(:destroy).validate(false) }
	it { should have_and_belong_to_many(:causes).class_name('EventCause') }
	it { should accept_nested_attributes_for(:alarms).allow_destroy(true) }
	it { should accept_nested_attributes_for(:causes).allow_destroy(true) }

	it "should assign variable STATES" do
		states = %w[open evaluated solved closed]
		expect(ServiceEvent::STATES).to eq(states)
	end

	it { should delegate(:open?).to(:current_state) }
	it { should delegate(:evaluated?).to(:current_state) }
	it { should delegate(:solved?).to(:current_state) }
	it { should delegate(:closed?).to(:current_state) }

	describe "#self.query_state(state)" do
		let(:event) { create(:service_event) }

		it "returns an array of open service events" do
			expect(ServiceEvent.query_state("open")).to eq([event])
		end
	end

	describe "#current_state" do
		let!(:event) { create(:service_event) }	
		let!(:pstate) { mock_model(ServiceEventState) }
		it "gives the current state of an event" do
			expect(event.open?).to be_true
		end
	end
	

	describe "#event_prepare" do
		let!(:user) { create(:user2) }
		before do
			event = build(:service_event, user_id: nil)
			current_user = user
			event.save && event.reload
		end

		it "updates the hour counter of machine" do
			pending
		end

		it "assigns event name to record" do
			pending
		end
	end

	context "new saved record attributes" do
		let(:event) { create(:service_event) }

		it "has event_name set after creation" do
			event = create(:service_event, :event_name => nil)
			expect(event.event_name).not_to be_nil
		end
		
		it "assigns open state to a new saved event" do
			expect(event.open?).to be_true
		end
	end

	context "event already exists" do
		let(:event) { create(:service_event) }
		
		describe "#evaluate" do
			it "saves evaluated state for event" do
				event.evaluate
				expect(event.evaluated?).to be_true 	
			end 
		end
		
		describe "#solve" do
			it "saves solved state to event" do
				event.evaluate
				event.solve
				expect(event.closed?).to be_true
			end
		end

		describe "#close" do
			describe "saves closed state to event" do
				it "saves closed state to event" do
					event.evaluate
					event.solve
					expect(event.closed?).to be_true
				end
			end
			
		end
	end

	it 'sends notification mail on opening event' do
		ActionMailer::Base.deliveries = []
		create(:admin)
		admins = User.admins.collect(&:email).join(',')
		event = create(:service_event)
		ActionMailer::Base.deliveries.last.to.should == [admins]
		ActionMailer::Base.deliveries.last.subject.should == "#{event.event_name} is open"
	end

	it "sends notification mail on closing event" do
		admin = create(:admin)
		event = create(:service_event)
		event.evaluate
		event.solve
		ActionMailer::Base.deliveries = []
		event.close
		admins = User.admins.collect(&:email).join(',')
		ActionMailer::Base.deliveries.last.to.should == [admins]
		ActionMailer::Base.deliveries.last.subject.should == "#{event.event_name} is closed"
	end

	it "destroys alarms association from join table in a before_destroy callback" do
		event = create(:service_event_with_alarms)
		event.destroy
		expect(event.alarms.length).to eq(0)
	end
	
end