class CreateRuPusks < ActiveRecord::Migration
  def self.up
    create_table :ru_pusks do |t|
      t.string :kode
      t.string :nama
      t.boolean :default

      t.timestamps
    end
  end

  def self.down
    drop_table :ru_pusks
  end
end
