class AddSupportInfoToVerifikasi < ActiveRecord::Migration
  def self.up
    add_column :verifikasis, :no_klaim_rs, :string
    add_column :verifikasis, :no_skp_ejkbm, :string
    add_column :verifikasis, :norm, :string
    add_column :verifikasis, :no_daftar_rs, :string
  end

  def self.down
    remove_column :verifikasis, :no_daftar_rs
    remove_column :verifikasis, :norm
    remove_column :verifikasis, :no_skp_ejkbm
    remove_column :verifikasis, :no_klaim_rs
  end
end
