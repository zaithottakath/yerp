class AddSpatialIndexToBusiness < ActiveRecord::Migration
  def change
    change_table :businesses do |t|
      t.index :center, spatial: true
    end
  end
end
