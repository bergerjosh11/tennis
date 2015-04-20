class MatchesAddIsRated < ActiveRecord::Migration
  def self.up
    change_table :matches do |t|
      t.boolean :is_rated_by_first_player, :default => false
      t.boolean :is_rated_by_second_player, :default => false
    end
  end

  def self.down
    remove_column :matches, :is_rated_by_first_player
    remove_column :matches, :is_rated_by_second_player
  end
end
