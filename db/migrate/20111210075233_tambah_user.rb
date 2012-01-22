class TambahUser < ActiveRecord::Migration
  def self.up
    add_column :tindakan_medis, :iduser, :integer
    add_column :kategori_tindakan_medis, :iduser, :integer
    add_column :tindakan_penunjangs, :iduser, :integer
    add_column :kategori_tindakan_penunjangs, :iduser, :integer

    change_column :pemeriksaans, :flag, :integer
    change_column :tindakan_medis, :flag, :integer
    change_column :tindakan_penunjangs, :flag, :integer

  end

  def self.down
    remove_column :tindakan_medis, :iduser
    remove_column :kategori_tindakan_medis, :iduser
    remove_column :tindakan_penunjangs, :iduser
    remove_column :kategori_tindakan_penunjangs, :iduser
  end
end
