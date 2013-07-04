class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :business_id
      t.integer :rating
      t.string :comments

      t.timestamps
    end

    add_index :reviews, :user_id
    add_index :reviews, :business_id
    add_index :reviews, [:business_id, :rating]
  end
end
