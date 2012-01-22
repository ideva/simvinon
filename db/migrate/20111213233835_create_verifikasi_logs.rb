class CreateVerifikasiLogs < ActiveRecord::Migration
  def self.up
    create_table :verifikasi_logs do |t|
      t.integer :status_verifikasi_verifikator_sebelum
      t.integer :status_verifikasi_verifikator_sesudah
      t.integer :iduser

      t.timestamps
    end
  end

  def self.down
    drop_table :verifikasi_logs
  end
end
