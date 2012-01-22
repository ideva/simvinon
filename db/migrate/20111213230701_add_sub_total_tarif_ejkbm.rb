class AddSubTotalTarifEjkbm < ActiveRecord::Migration
  def self.up
    add_column :verifikasi_pemeriksaans, :sub_total_tarif_ejkbm, :double, :default => 0
  end

  def self.down
    remove_column :verifikasi_pemeriksaans, :sub_total_tarif_ejkbm
  end
end
