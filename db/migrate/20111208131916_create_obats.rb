class CreateObats < ActiveRecord::Migration
  def self.up
    create_table :obats do |t|
      t.string :kode
      t.string :nama
      t.string :kode_kategori
      t.string :bentuk_kekuatan_kemasan
      t.integer :jumlah
      t.string :satuan
      t.float :het_satuan
      t.integer :het_pack

      t.timestamps
    end
  end

  def self.down
    drop_table :obats
  end
end
