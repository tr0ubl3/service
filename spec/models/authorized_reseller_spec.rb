require 'spec_helper'

describe AuthorizedReseller do
  # test if inherits from Firm model
  specify { AuthorizedReseller.should be < Firm }
end
