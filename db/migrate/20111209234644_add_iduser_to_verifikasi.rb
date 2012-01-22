class AddIduserToVerifikasi < ActiveRecord::Migration
  def self.up
    add_column :verifikasis, :iduser, :integer
  end

  def self.down
    remove_column :verifikasis, :iduser, :integer
  end
end
