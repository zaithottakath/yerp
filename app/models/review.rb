class Review < ActiveRecord::Base
  attr_accessible :comments, :rating, :business_id

  belongs_to :user
  belongs_to :business
end
