class ChangeTarifFromVerifikasiPelayananLain < ActiveRecord::Migration
  def self.up
    change_column :verifikasi_pelayanan_lains, :satuan_tarif_ejkbm, :double, :default => 0
    change_column :verifikasi_pelayanan_lains, :sub_total_tarif_ejkbm, :double, :default => 0
  end

  def self.down
    change_column :verifikasi_pelayanan_lains, :satuan_tarif_ejkbm, :float, :default => 0
    change_column :verifikasi_pelayanan_lains, :sub_total_tarif_ejkbm, :float, :default => 0
  end
end
