class AddJenisPelayananToVerifikasi < ActiveRecord::Migration
  def self.up
    add_column :verifikasis, :jenis_pelayanan, :integer
  end

  def self.down
    remove_column :verifikasis, :jenis_pelayanan
  end
end
