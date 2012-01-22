class CreateVerifikasiTindakans < ActiveRecord::Migration
  def self.up
    create_table(:verifikasi_tindakans) do |t|
      t.string :kode, :null => false
      t.string :kode_verifikasi
      t.string :kode_t_medis
      t.integer :jumlah_t_medis
      t.integer :flag

      t.timestamps
    end

  end

  def self.down
    drop_table :verifikasi_tindakans
  end
end
