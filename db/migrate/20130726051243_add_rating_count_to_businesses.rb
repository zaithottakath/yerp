class AddRatingCountToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :rating_count, :integer
    add_index :businesses, :rating_count
  end
end
