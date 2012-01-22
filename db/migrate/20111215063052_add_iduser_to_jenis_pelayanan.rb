class AddIduserToJenisPelayanan < ActiveRecord::Migration
  def self.up
    add_column :jenis_pelayanans, :iduser, :integer
  end

  def self.down
    remove_column :jenis_pelayanans, :iduser, :integer
  end
end
