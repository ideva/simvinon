class AddKodeVerifikasiToVerifikasiToEjkbmFirst < ActiveRecord::Migration
  def self.up
    add_column :verifikasi_to_ejkbm_firsts, :kode_verifikasi, :string
  end

  def self.down
    remove_column :verifikasi_to_ejkbm_firsts, :kode_verifikasi
  end
end
