class RenameColumnKodeTMedisToVerifikasiTindakan < ActiveRecord::Migration
  def self.up
    rename_column :verifikasi_tindakans, :kode_t_medis, :kode_t_medis_rs
    rename_column :verifikasi_tindakans, :jumlah_t_medis, :jumlah_t_medis_rs
    rename_column :verifikasi_tindakans, :nama_t_medis, :nama_t_medis_rs
  end

  def self.down
    rename_column :verifikasi_tindakans, :kode_t_medis_rs, :kode_t_medis
    rename_column :verifikasi_tindakans, :jumlah_t_medis_rs, :jumlah_t_medis
    rename_column :verifikasi_tindakans, :nama_t_medis_rs, :nama_t_medis
  end
end
