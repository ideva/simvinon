class AddIdUserLevelToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :iduser_level, :integer, :default => 3
  end

  def self.down
    remove_column :users, :iduser_level
  end
end
