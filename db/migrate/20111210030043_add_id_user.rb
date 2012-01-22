class AddIdUser < ActiveRecord::Migration
  def self.up
    add_column :obats, :iduser, :integer
    add_column :kategori_obats, :iduser, :integer
    add_column :pemeriksaans, :iduser, :integer
    add_column :mapping_data_obats, :iduser, :integer
    add_column :mapping_data_pemeriksaans, :iduser, :integer
    add_column :mapping_data_tindakan_medis, :iduser, :integer
    add_column :mapping_data_tindakan_penunjangs, :iduser, :integer
  end

  def self.down
    remove_column :obats, :iduser
    remove_column :kategori_obats, :iduser
    remove_column :pemeriksaans, :iduser
    remove_column :mapping_data_obats, :iduser
    remove_column :mapping_data_pemeriksaans, :iduser
    remove_column :mapping_data_tindakan_medis, :iduser
    remove_column :mapping_data_tindakan_penunjangs, :iduser
  end
end
