class RenameColumnSatuanTarifFromVerifikasiPelayananLain < ActiveRecord::Migration
  def self.up
    rename_column :verifikasi_pelayanan_lains, :satuan_tarif_ejkbm, :satuan_tarif
    rename_column :verifikasi_pelayanan_lains, :sub_total_tarif_ejkbm, :sub_total_tarif
  end

  def self.down
    rename_column :verifikasi_pelayanan_lains, :satuan_tarif, :satuan_tarif_ejkbm
    rename_column :verifikasi_pelayanan_lains, :sub_total_tarif, :sub_total_tarif_ejkbm
  end
end
