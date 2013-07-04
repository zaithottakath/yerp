FactoryGirl.define do
  factory :user do
    #a sequence should go in here
    sequence :email do |n|
      "ticketee#{n}@example.com"
    end
    password "password"
    password_confirmation "password"

    factory :confirmed_user do
      after_create do |user|
        user.confirm!
      end
    end
#    factory :admin_user do
#      after_create do |user|
#        user.confirm!
#        user.update_attribute(:admin, true)
#      end
#    end
  end
end
