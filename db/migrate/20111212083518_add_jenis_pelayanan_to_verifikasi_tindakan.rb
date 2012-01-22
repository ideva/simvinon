class AddJenisPelayananToVerifikasiTindakan < ActiveRecord::Migration
  def self.up
    add_column :verifikasi_tindakans, :jenis_pelayanan, :integer, :default => 1
  end

  def self.down
    remove_column :verifikasi_tindakans, :jenis_pelayanan
  end
end
