require 'spec_helper'

describe Alarm do
	it { should belong_to(:machine_group) }
	it { should have_and_belong_to_many(:service_events) }
	it { should allow_mass_assignment_of(:number) }
	it { should allow_mass_assignment_of(:text) }
	it { should allow_mass_assignment_of(:machine_group_id) }
	it { should validate_presence_of(:number) }
	it { should validate_uniqueness_of(:number).scoped_to(:machine_group_id) }

	describe "search scope" do
		let(:alarm) { create(:alarm, number: "700123", machine_group_id: 1) }

		it "searches an alarm by number" do
			expect(Alarm.search("700123", 1)).to eq([alarm])
		end
	end

	describe "#import" do
		let(:alarm) { create(:alarm) }
		let(:group) { create(:machine_group) }
		
		before :each do
			@file = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/alarms_valid.csv')))
			Alarm.delete_all
			Alarm.import(@file, group.id)

		end

		it "saves records from csv file" do
			expect(Alarm.all.length).to eq(@file.readlines.size-1)
		end

		it "returns true if import was ok" do
			Alarm.delete_all
			expect(Alarm.import(@file, group.id)).to be_true
			expect(Alarm.first.machine_group_id).not_to be_nil
		end
		context "file is not a csv" do
			before :each do
				@file = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/alarms_valid.nil')))
				Alarm.delete_all
				Alarm.import(@file, group.id)
			end

			it "doesn't save records to db" do
				expect(Alarm.all.length).to eq(0)
			end

			it "return false if import was nok" do
				Alarm.delete_all
				expect(Alarm.import(@file, group.id)).to be_false
			end

			it "rescues from CSV::MalformedCSVError" do
				@file = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/malformed.csv')))
				expect(Alarm.import(@file, group.id)).to be_false
			end
		end
	end
end
