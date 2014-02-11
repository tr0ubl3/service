require 'spec_helper'

describe Firm do
	it { should have_many(:users) }
end