require 'spec_helper'

describe EventCause do
  it { should belong_to(:service_event) }
end
