class ChangeColumnStatusVerifikasiVerifikatorFromVerikasi < ActiveRecord::Migration
  def self.up
    change_column :verifikasis, :status_verifikasi_verifikator, :integer, :default => 0
  end

  def self.down
    change_column :verifikasis, :status_verifikasi_verifikator, :boolean
  end
end
