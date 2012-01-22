class CreateMappingPelayananLains < ActiveRecord::Migration
  def self.up
    create_table :mapping_pelayanan_lains do |t|
      t.string :kode_pelayanan_lain_rs
      t.string :kode_pelayanan_lain_ejkbm
      t.integer :iduser

      t.timestamps
    end
  end

  def self.down
    drop_table :mapping_pelayanan_lains
  end
end
