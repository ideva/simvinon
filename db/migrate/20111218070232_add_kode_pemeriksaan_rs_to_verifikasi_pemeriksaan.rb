class AddKodePemeriksaanRsToVerifikasiPemeriksaan < ActiveRecord::Migration
  def self.up
    add_column :verifikasi_pemeriksaans, :kode_pemeriksaan_rs, :string
  end

  def self.down
    remove_column :verifikasi_pemeriksaans, :kode_pemeriksaan_rs
  end
end
