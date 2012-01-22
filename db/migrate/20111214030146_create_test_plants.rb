class CreateTestPlants < ActiveRecord::Migration
  def self.up
    create_table :test_plants do |t|
      t.string :tanggal
      t.string :menu
      t.string :url
      t.text :skenario
      t.boolean :hasil
      t.text :deskripsi_hasil
      t.text :komentar
      t.string :image
      t.integer :iduser

      t.timestamps
    end
  end

  def self.down
    drop_table :test_plants
  end
end
