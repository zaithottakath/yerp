class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :address
      t.point :center, :srid => 4326, :null => false

      t.timestamps
    end
  end
end
