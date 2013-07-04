class CreateAvatarsForRailsBusiness < ActiveRecord::Migration
  def up    
    add_attachment :businesses, :logo
  end
  
  def self.down
    remove_attachment :businesses, :logo
  end
end
