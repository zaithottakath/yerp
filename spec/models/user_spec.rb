require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  subject { user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:age) }
  it { should respond_to(:location) }
  it { should respond_to(:best_comments) }

  it { should respond_to(:remember_me) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }


  it { should be_valid }

  describe 'creating business' do

  end

end
