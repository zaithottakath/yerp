require 'spec_helper'

describe Business do
  create_business
  subject { business }

  it { should be_valid }
end
