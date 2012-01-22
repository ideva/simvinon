class AddKabupatenAndNamaTmAndObatToVerifikasi < ActiveRecord::Migration
  def self.up
    add_column :verifikasis, :kode_kabupaten, :string
  end

  def self.down
    remove_column :verifikasis, :kode_kabupaten
  end
end
