class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.integer :owner_id
      t.integer :first_player_id
      t.integer :second_player_id
      t.integer :winner_id
      
      t.boolean :was_played, :default => false
      t.boolean :info_provided, :default => false 
      t.boolean :info_denied, :default => false
      t.text :why_denied
      
      t.date :when
      t.string :where
      t.string :score
      
      t.text :first_players_description
      t.text :second_players_description
      
      t.boolean :first_player_ignores, :default => false
      t.boolean :second_player_ignores, :default => false
      
      t.boolean :tournament_match, :default => false
      t.string :tournament_phase
      
      t.timestamps
    end
  end

  def self.down
    drop_table :matches
  end
end
