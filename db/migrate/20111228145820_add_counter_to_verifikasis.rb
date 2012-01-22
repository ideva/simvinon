class AddCounterToVerifikasis < ActiveRecord::Migration
  def self.up
    add_column :verifikasis, :counter, :integer, :default => 0
  end

  def self.down
    remove_column :verifikasis, :counter
  end
end
