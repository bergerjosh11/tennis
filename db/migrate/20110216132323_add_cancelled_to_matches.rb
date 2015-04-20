class AddCancelledToMatches < ActiveRecord::Migration
  def self.up
    change_table :matches do |t|
      t.boolean :cancelled, :default => false
    end
    
    Match.update_all ["cancelled = ?", false]
  end

  def self.down
    remove_column :matches, :cancelled
  end
end
