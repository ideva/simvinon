class CreateTindakanPenunjangs < ActiveRecord::Migration
  def self.up
    create_table :tindakan_penunjangs do |t|
      t.string :kode
      t.string :kode_kategori_tindakan_penunjang
      t.string :nama
      t.integer :tarif
      t.string :flag

      t.timestamps
    end
  end

  def self.down
    drop_table :tindakan_penunjangs
  end
end
