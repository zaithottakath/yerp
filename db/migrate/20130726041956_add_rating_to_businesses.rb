class AddRatingToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :rating, :float
    add_index :businesses, :rating
  end
end
