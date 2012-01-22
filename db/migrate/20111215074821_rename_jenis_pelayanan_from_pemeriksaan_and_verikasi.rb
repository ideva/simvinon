class RenameJenisPelayananFromPemeriksaanAndVerikasi < ActiveRecord::Migration
  def self.up
    rename_column :pemeriksaans, :jenis_pelayanan, :kode_jenis_pelayanan
    rename_column :verifikasis, :jenis_pelayanan, :kode_jenis_pelayanan
  end

  def self.down
    rename_column :pemeriksaans, :kode_jenis_pelayanan, :jenis_pelayanan
    rename_column :verifikasis, :kode_jenis_pelayanan, :jenis_pelayanan
  end
end
