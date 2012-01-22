class AddKodeKecamatanAndKodeKabupatenToRuPusk < ActiveRecord::Migration
  def self.up
    add_column :ru_pusks, :kode_kecamatan, :string
    add_column :ru_pusks, :kode_kabupaten, :string
  end

  def self.down
    remove_column :ru_pusks, :kode_kabupaten
    remove_column :ru_pusks, :kode_kecamatan
  end
end
