class CreateVerifikasiPemeriksaans < ActiveRecord::Migration
  def self.up
    create_table :verifikasi_pemeriksaans do |t|
      t.string :kode
      t.string :kode_verifikasi
      t.string :kode_pemeriksaan_ejkbm
      t.float :tarif_pemeriksaan

      t.timestamps
    end
  end

  def self.down
    drop_table :verifikasi_pemeriksaans
  end
end
