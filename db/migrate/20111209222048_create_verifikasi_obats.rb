class CreateVerifikasiObats < ActiveRecord::Migration
  def self.up
    create_table(:verifikasi_obats) do |t|
      t.string :kode, :null => false
      t.string :kode_verifikasi
      t.string :kode_obat
      t.integer :jumlah_obat

      t.timestamps
    end
  end

  def self.down
    drop_table :verifikasi_obats
  end
end
