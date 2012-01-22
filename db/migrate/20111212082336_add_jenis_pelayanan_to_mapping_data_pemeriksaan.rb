class AddJenisPelayananToMappingDataPemeriksaan < ActiveRecord::Migration
  def self.up
    add_column :mapping_data_pemeriksaans, :jenis_pelayanan, :integer
  end

  def self.down
    remove_column :mapping_data_pemeriksaans, :jenis_pelayanan
  end
end
