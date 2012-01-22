class ChangeColumnJenisPelayananToPemeriksaan < ActiveRecord::Migration
  def self.up
    change_column :pemeriksaans, :jenis_pelayanan, :string, :default => ""
  end

  def self.down
  end
end
