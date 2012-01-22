class AddSupportInfoToVerifikasiTindakan < ActiveRecord::Migration
  def self.up
    add_column :verifikasi_tindakans, :kode_t_medis_ejkbm, :string
    add_column :verifikasi_tindakans, :satuan_tarif_ejkbm, :float, :default => 0
    add_column :verifikasi_tindakans, :sub_total_tarif_ejkbm, :float, :default => 0
    add_column :verifikasi_tindakans, :iduser, :integer
  end

  def self.down
    remove_column :verifikasi_tindakans, :iduser
    remove_column :verifikasi_tindakans, :sub_total_tarif_ejkbm
    remove_column :verifikasi_tindakans, :satuan_tarif_ejkbm
    remove_column :verifikasi_tindakans, :kode_t_medis_ejkbm
  end
end
