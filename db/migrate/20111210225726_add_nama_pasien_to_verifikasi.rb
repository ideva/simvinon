class AddNamaPasienToVerifikasi < ActiveRecord::Migration
  def self.up
    add_column :verifikasis, :nama_pasien, :string
  end

  def self.down
    remove_column :verifikasis, :nama_pasien
  end
end
