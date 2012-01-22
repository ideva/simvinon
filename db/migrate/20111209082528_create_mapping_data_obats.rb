class CreateMappingDataObats < ActiveRecord::Migration
  def self.up
    create_table :mapping_data_obats do |t|
      t.string :kode_rs
      t.string :kode_ejkbm

      t.timestamps
    end
  end

  def self.down
    drop_table :mapping_data_obats
  end
end
