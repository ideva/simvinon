class AddNamaObatToVerifikasiObat < ActiveRecord::Migration
  def self.up
    add_column :verifikasi_obats, :nama_obat, :string
  end

  def self.down
    remove_column :verifikasi_obats, :nama_obat
  end
end
