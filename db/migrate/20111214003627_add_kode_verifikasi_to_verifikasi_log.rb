class AddKodeVerifikasiToVerifikasiLog < ActiveRecord::Migration
  def self.up
    add_column :verifikasi_logs, :kode_verifikasi, :string
  end

  def self.down
    remove_column :verifikasi_logs, :kode_verifikasi
  end
end
