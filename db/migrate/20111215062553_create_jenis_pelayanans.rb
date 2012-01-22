class CreateJenisPelayanans < ActiveRecord::Migration
  def self.up
    create_table :jenis_pelayanans do |t|
      t.string :kode
      t.string :nama

      t.timestamps
    end
  end

  def self.down
    drop_table :jenis_pelayanans
  end
end
