require "spec_helper"

describe EventNotifier do
  describe "confirmation" do
    let(:mail) { EventNotifier.confirmation }

    it "renders the headers" do
      mail.subject.should eq("Confirmation")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "notification" do
    let(:mail) { EventNotifier.notification }

    it "renders the headers" do
      mail.subject.should eq("Notification")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
