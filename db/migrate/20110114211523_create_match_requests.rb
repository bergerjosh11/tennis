class CreateMatchRequests < ActiveRecord::Migration
  def self.up
    create_table :match_requests do |t|
      t.integer :owner_id
      t.integer :second_player_id
      
      t.boolean :cancelled, :default => false
      t.boolean :denied, :default => false
      t.boolean :accepted, :default => false
      
      t.integer :match_id
      
      t.text :why_denied
      
      t.text :description
      
      t.timestamps
    end
  end

  def self.down
    drop_table :match_requests
  end
end
