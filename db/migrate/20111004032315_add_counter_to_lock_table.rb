class AddCounterToLockTable < ActiveRecord::Migration
  def self.up
    add_column :lock_tables, :counter, :integer, :default => 0
  end

  def self.down
    remove_column :lock_tables, :counter
  end
end
