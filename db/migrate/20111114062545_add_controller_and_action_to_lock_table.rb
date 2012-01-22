class AddControllerAndActionToLockTable < ActiveRecord::Migration
  def self.up
    add_column :lock_tables, :controller_name, :string
    add_column :lock_tables, :action_name, :string
  end

  def self.down
    remove_column :lock_tables, :action_name
    remove_column :lock_tables, :controller_name
  end
end
