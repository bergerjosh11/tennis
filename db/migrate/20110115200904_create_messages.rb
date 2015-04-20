class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.text :content
      t.boolean :read, :default => false
      
      t.integer :author_id
      t.integer :addressee_id
      t.integer :match_id
      t.integer :match_request_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
