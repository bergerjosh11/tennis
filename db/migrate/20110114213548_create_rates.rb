class CreateRates < ActiveRecord::Migration
  def self.up
    create_table :rates do |t|
      t.integer :rate_value
      t.text :description
      
      t.integer :who_gave_id
      t.integer :owner_id
      t.integer :match_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :rates
  end
end
