require 'spec_helper'

describe Manifestation do
  it { should belong_to(:service_event) }
  it { should belong_to(:symptom) }
end
