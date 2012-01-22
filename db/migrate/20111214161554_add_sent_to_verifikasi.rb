class AddSentToVerifikasi < ActiveRecord::Migration
  def self.up
    add_column :verifikasis, :sent_to_ejkbm, :boolean, :default => false
    add_column :verifikasis, :sent_to_rs, :boolean, :default => false
  end

  def self.down
    remove_column :verifikasis, :sent_to_rs
    remove_column :verifikasis, :sent_to_ejkbm
  end
end
