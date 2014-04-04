require 'spec_helper'

describe MachineGroup do
  it { should belong_to(:manufacturer) }
  it { should have_many(:machines) }
  it { should have_many(:alarms) }
end
