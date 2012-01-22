class AddIdToLockToLockTable < ActiveRecord::Migration
  def self.up
    add_column :lock_tables, :id_to_lock, :integer
  end

  def self.down
    remove_column :lock_tables, :id_to_lock
  end
end
