class AddMappingInfoToMappingDataPemeriksaan < ActiveRecord::Migration
  def self.up
    add_column :mapping_data_pemeriksaans, :kode_pemeriksaan_ejkbm, :string
    add_column :mapping_data_pemeriksaans, :kode_pemeriksaan_rs, :string
  end

  def self.down
    remove_column :mapping_data_pemeriksaans, :kode_pemeriksaan_rs
    remove_column :mapping_data_pemeriksaans, :kode_pemeriksaan_ejkbm
  end
end
