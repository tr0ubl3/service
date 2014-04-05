require 'spec_helper'

describe AuthorizedReseller do
  
  specify { AuthorizedReseller.should be < Firm }
  it { should have_many(:machines) }
  it { should have_many(:users) }
end
