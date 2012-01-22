class CreatePelayananLains < ActiveRecord::Migration
  def self.up
    create_table :pelayanan_lains do |t|
      t.string :kode
      t.string :nama
      t.string :tarif
      t.string :iduser

      t.timestamps
    end
  end

  def self.down
    drop_table :pelayanan_lains
  end
end
