class CreateVerifikasiPelayananLains < ActiveRecord::Migration
  def self.up
    create_table :verifikasi_pelayanan_lains do |t|
      t.string :kode
      t.string :kode_verifikasi
      t.string :kode_pelayanan_lain_ejkbm
      t.string :kode_pelayanan_lain_rs
      t.integer :jumlah_pelayanan_lain_rs
      t.string :nama_pelayanan_lain_rs
      t.string :tgl_pelayanan_lain_rs
      t.integer :flag
      t.float :satuan_tarif_ejkbm
      t.float :sub_total_tarif_ejkbm
      t.integer :iduser

      t.timestamps
    end
  end

  def self.down
    drop_table :verifikasi_pelayanan_lains
  end
end
