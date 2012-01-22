class AddAlamatToVerifikasis < ActiveRecord::Migration
  def self.up
    add_column :verifikasis, :alamat, :string
  end

  def self.down
    remove_column :verifikasis, :alamat
  end
end
