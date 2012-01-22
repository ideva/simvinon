class AddSupportInfoToVerifikasiObat < ActiveRecord::Migration
  def self.up
    add_column :verifikasi_obats, :kode_obat_ejkbm, :string
    add_column :verifikasi_obats, :satuan_tarif_ejkbm, :float, :default => 0
    add_column :verifikasi_obats, :sub_total_tarif_ejkbm, :float, :default => 0
    add_column :verifikasi_obats, :iduser, :integer
  end

  def self.down
    remove_column :verifikasi_obats, :iduser
    remove_column :verifikasi_obats, :sub_total_tarif_ejkbm
    remove_column :verifikasi_obats, :satuan_tarif_ejkbm
    remove_column :verifikasi_obats, :kode_obat_ejkbm
  end
end
