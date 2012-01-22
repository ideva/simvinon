class AddKodeInstalasiLayananToVerifikasi < ActiveRecord::Migration
  def self.up
    add_column :verifikasis, :kode_instalasi_layanan, :string
    add_column :verifikasis, :nama_instalasi_layanan, :string
  end

  def self.down
    remove_column :verifikasis, :nama_instalasi_layanan
    remove_column :verifikasis, :kode_instalasi_layanan
  end
end
