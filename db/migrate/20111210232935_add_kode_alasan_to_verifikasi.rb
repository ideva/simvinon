class AddKodeAlasanToVerifikasi < ActiveRecord::Migration
  def self.up
    add_column :verifikasis, :kode_alasan_verifikasi, :string
  end

  def self.down
    remove_column :verifikasis, :kode_alasan_verifikasi
  end
end
