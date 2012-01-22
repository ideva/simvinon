class AddJenisPelayananToPemeriksaan < ActiveRecord::Migration
  def self.up
    add_column :pemeriksaans, :jenis_pelayanan, :integer
  end

  def self.down
    remove_column :pemeriksaans, :jenis_pelayanan
  end
end
