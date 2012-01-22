class CreatePemeriksaans < ActiveRecord::Migration
  def self.up
    create_table :pemeriksaans do |t|
      t.string :kode
      t.string :nama
      t.integer :tarif
      t.boolean :flag

      t.timestamps
    end
  end

  def self.down
    drop_table :pemeriksaans
  end
end
