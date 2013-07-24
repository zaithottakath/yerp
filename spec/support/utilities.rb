include ApplicationHelper

def create_user
  let(:user) { FactoryGirl.create(:user) }
end

def create_business
  let(:business) { FactoryGirl.create(:business) }
end

def sign_in_as!(user)
  visit '/users/sign_in'
  fill_in "Email", :with => user.email
  fill_in "Password", :with => "password"
  click_button 'Sign in'
  page.should have_content('Sign out')
end

