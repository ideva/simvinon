class RenameColumnToMappingDataPemeriksaan < ActiveRecord::Migration
  def self.up
    rename_column :mapping_data_pemeriksaans, :kode_rs, :kode_tm_rs
    rename_column :mapping_data_pemeriksaans, :kode_ejkbm, :kode_tm_ejkbm
  end

  def self.down
    rename_column :mapping_data_pemeriksaans, :kode_tm_rs, :kode_rs
    rename_column :mapping_data_pemeriksaans, :kode_tm_ejkbm, :kode_ejkbm
  end
end
