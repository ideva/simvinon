class CreateAlasanVerifikasis < ActiveRecord::Migration
  def self.up
    create_table :alasan_verifikasis do |t|
      t.string :kode
      t.string :alasan
      t.integer :iduser

      t.timestamps
    end
  end

  def self.down
    drop_table :alasan_verifikasis
  end
end
