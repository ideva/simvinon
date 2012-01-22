class AddFlagAndIduserToVerifikasiPemeriksaan < ActiveRecord::Migration
  def self.up
    add_column :verifikasi_pemeriksaans, :flag, :integer
    add_column :verifikasi_pemeriksaans, :iduser, :integer
  end

  def self.down
    remove_column :verifikasi_pemeriksaans, :iduser
    remove_column :verifikasi_pemeriksaans, :flag
  end
end
