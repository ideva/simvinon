class AddStatusVerifikatorAndAlasanToSemuaPelayananRs < ActiveRecord::Migration
  def self.up
    add_column :verifikasi_tindakans, :status_verifikasi_sistem, :boolean, :default => false
    add_column :verifikasi_tindakans, :status_verifikasi_verifikator, :integer, :default => 0
    add_column :verifikasi_tindakans, :kode_alasan_verifikasi, :string
    add_column :verifikasi_tindakans, :komentar, :string

    add_column :verifikasi_obats, :status_verifikasi_sistem, :boolean, :default => false
    add_column :verifikasi_obats, :status_verifikasi_verifikator, :integer, :default => 0
    add_column :verifikasi_obats, :kode_alasan_verifikasi, :string
    add_column :verifikasi_obats, :komentar, :string

    add_column :verifikasi_pemeriksaans, :status_verifikasi_sistem, :boolean, :default => false
    add_column :verifikasi_pemeriksaans, :status_verifikasi_verifikator, :integer, :default => 0
    add_column :verifikasi_pemeriksaans, :kode_alasan_verifikasi, :string
    add_column :verifikasi_pemeriksaans, :komentar, :string

    add_column :verifikasi_pelayanan_lains, :status_verifikasi_sistem, :boolean, :default => false
    add_column :verifikasi_pelayanan_lains, :status_verifikasi_verifikator, :integer, :default => 0
    add_column :verifikasi_pelayanan_lains, :kode_alasan_verifikasi, :string
    add_column :verifikasi_pelayanan_lains, :komentar, :string
  end

  def self.down
  end
end
