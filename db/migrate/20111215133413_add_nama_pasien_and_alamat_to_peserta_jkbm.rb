class AddNamaPasienAndAlamatToPesertaJkbm < ActiveRecord::Migration
  def self.up
    add_column :peserta_jkbms, :nama_pasien, :string
    add_column :peserta_jkbms, :alamat, :text
  end

  def self.down
    remove_column :peserta_jkbms, :alamat
    remove_column :peserta_jkbms, :nama_pasien
  end
end
