class AddTglObatToVerifikasiObat < ActiveRecord::Migration
  def self.up
    add_column :verifikasi_obats, :tgl_obat, :string
  end

  def self.down
    remove_column :verifikasi_obats, :tgl_obat
  end
end
