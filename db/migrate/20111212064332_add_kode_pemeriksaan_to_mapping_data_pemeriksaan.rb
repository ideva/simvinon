class AddKodePemeriksaanToMappingDataPemeriksaan < ActiveRecord::Migration
  def self.up
    add_column :mapping_data_pemeriksaans, :kode_pemeriksaan, :string
  end

  def self.down
    remove_column :mapping_data_pemeriksaans, :kode_pemeriksaan
  end
end
