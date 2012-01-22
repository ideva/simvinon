class CreateVerifikasis < ActiveRecord::Migration
  def self.up
    create_table(:verifikasis) do |t|
      t.string :kode, :null => false
      t.string :no_pelayanan, :default => ""
      t.string :tgl_masuk, :default => ""
      t.string :tgl_keluar, :default => ""
      t.integer :lama_dirawat, :default => 0
      t.string :no_kk, :default => ""
      t.string :nik, :default => ""
      t.string :ktp, :default => ""
      t.string :dokter, :default => ""
      t.string :poli, :default => ""
      t.string :keluhan, :default => ""
      t.string :diagnosa_icd, :default => ""
      t.boolean :status_pengiriman, :default => false
      t.boolean :status_verifikasi_sistem, :default => false
      t.boolean :status_verifikasi_verifikator

      t.timestamps
    end
  end

  def self.down
    drop_table :verifikasis
  end
end
