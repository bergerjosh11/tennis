class CreateProfiles < ActiveRecord::Migration
    def self.up
        create_table :profiles do |t|
            t.string :nick
            t.string :first_name
            t.string :last_name
            t.string :city
            t.string :state
            t.decimal :ntrp
          
            t.string :email
            
            t.boolean :active, :default => true  
            
            t.boolean :hide_name, :default => false
            
            t.integer :user_id
            
            t.timestamps
        end
    end

    def self.down
        drop_table :profiles
    end
end
