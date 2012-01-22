class AddTglTMedisRsToVerifikasiTindakan < ActiveRecord::Migration
  def self.up
    add_column :verifikasi_tindakans, :tgl_t_medis_rs, :string
  end

  def self.down
    remove_column :verifikasi_tindakans, :tgl_t_medis_rs
  end
end
