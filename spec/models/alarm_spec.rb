require 'spec_helper'

describe Alarm do
	it { should belong_to(:machine_group) }
	it { should have_and_belong_to_many(:service_events) }
	it { should allow_mass_assignment_of(:number) }
	it { should allow_mass_assignment_of(:text) }
	it { should validate_presence_of(:number) }
	it { should validate_uniqueness_of(:number) }

	describe "search scope" do
		let(:alarm) { create(:alarm, number: "700123") }

		it "searches an alarm by number" do
			expect(Alarm.search("700123")).to eq([alarm])
		end
	end

	describe "#import" do
		let(:alarm) { create(:alarm) }
		
		before :each do
			@file = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/alarms_valid.csv')))
			Alarm.delete_all
			Alarm.import(@file)
		end

		it "saves records from csv file" do
			expect(Alarm.all.length).to eq(@file.readlines.size-1)
		end

		it "returns true if import was ok" do
			Alarm.delete_all
			expect(Alarm.import(@file)).to be_true
		end
	end
end
