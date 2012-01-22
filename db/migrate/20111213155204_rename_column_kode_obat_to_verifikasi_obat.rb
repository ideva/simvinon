class RenameColumnKodeObatToVerifikasiObat < ActiveRecord::Migration
  def self.up
    rename_column :verifikasi_obats, :kode_obat, :kode_obat_rs
    rename_column :verifikasi_obats, :jumlah_obat, :jumlah_obat_rs
    rename_column :verifikasi_obats, :nama_obat, :nama_obat_rs
  end

  def self.down
    rename_column :verifikasi_obats, :kode_obat_rs, :kode_obat
    rename_column :verifikasi_obats, :jumlah_obat_rs, :jumlah_obat
    rename_column :verifikasi_obats, :nama_obat_rs, :nama_obat
  end
end
