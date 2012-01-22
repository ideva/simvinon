class UbahHarga < ActiveRecord::Migration
  def self.up
    change_column :obats, :jumlah, :integer, :default => 0
    change_column :obats, :het_satuan, :double, :default => 0
    change_column :obats, :het_pack, :double, :default => 0
    change_column :pemeriksaans, :tarif, :double, :default => 0
    change_column :tindakan_medis, :tarif, :double, :default => 0
    change_column :tindakan_penunjangs, :tarif, :double, :default => 0
    change_column :verifikasis, :total_tarif, :double, :default => 0
    change_column :verifikasi_tindakans, :satuan_tarif_ejkbm, :double, :default => 0
    change_column :verifikasi_tindakans, :sub_total_tarif_ejkbm, :double, :default => 0
    change_column :verifikasi_pemeriksaans, :tarif_pemeriksaan, :double, :default => 0
    change_column :verifikasi_obats, :satuan_tarif_ejkbm, :double, :default => 0
    change_column :verifikasi_obats, :sub_total_tarif_ejkbm, :double, :default => 0
  end

  def self.down
  end
end
