class AddTransaksiNoToPemeriksaan < ActiveRecord::Migration
  def self.up
    add_column :verifikasi_pemeriksaans, :no_transaksi, :string
    add_column :verifikasi_tindakans, :no_transaksi, :string
    add_column :verifikasi_obats, :no_transaksi, :string
    add_column :verifikasi_pelayanan_lains, :no_transaksi, :string
  end

  def self.down
    remove_column :verifikasi_pemeriksaans, :no_transaksi
    remove_column :verifikasi_tindakans, :no_transaksi
    remove_column :verifikasi_obats, :no_transaksi
    remove_column :verifikasi_pelayanan_lains, :no_transaksi
  end
end
