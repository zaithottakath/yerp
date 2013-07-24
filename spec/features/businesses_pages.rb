require 'spec_helper'


describe "Businesses" do

  subject { page }



  describe "visiting Business" do
    create_user
    create_business

    it "should exist" do
      visit business_path(business)
      should have_text(business.name)
      should have_text(business.address)
      #binding.pry
    end

    it "while not signed in" do
      business.save
      visit businesses_path
      should have_text('Listing businesses')
      should have_text(business.address)
      should have_link(business.name, href: business_path(business))
    end

    it "while signed in" do
      business.save
      sign_in_as!(user)
      visit businesses_path
      should have_text('Listing businesses')
      should have_text(business.address)
      should have_link(business.name, href: business_path(business))
    end
    describe "while signed in" do

    end

  end
end
