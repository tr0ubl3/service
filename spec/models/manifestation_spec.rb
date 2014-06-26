require 'spec_helper'

describe Manifestation do
  it { should allow_mass_assignment_of(:service_event_id) }
  it { should allow_mass_assignment_of(:event_cause_id) }
  it { should allow_mass_assignment_of(:symptom_id) }
  it { should belong_to(:service_event) }
  it { should belong_to(:event_cause) }
  it { should belong_to(:symptom) }
end
