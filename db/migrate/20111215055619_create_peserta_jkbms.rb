class CreatePesertaJkbms < ActiveRecord::Migration
  def self.up
    create_table :peserta_jkbms do |t|
      t.string :kode
      t.string :no_pelayanan
      t.string :no_kk
      t.string :nik
      t.string :ktp
      t.string :no_ejkbm
      t.string :kode_kabupaten
      t.integer :flag

      t.timestamps
    end
  end

  def self.down
    drop_table :peserta_jkbms
  end
end
