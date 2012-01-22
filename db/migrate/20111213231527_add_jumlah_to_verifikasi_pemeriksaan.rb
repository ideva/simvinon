class AddJumlahToVerifikasiPemeriksaan < ActiveRecord::Migration
  def self.up
    add_column :verifikasi_pemeriksaans, :jumlah, :integer
  end

  def self.down
    remove_column :verifikasi_pemeriksaans, :jumlah
  end
end
