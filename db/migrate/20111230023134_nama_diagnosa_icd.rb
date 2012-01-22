class NamaDiagnosaIcd < ActiveRecord::Migration
  def self.up
    add_column :verifikasis, :nama_diagnosa_icd, :text
  end

  def self.down
    remove_column :verifikasis, :nama_diagnosa_icd
  end
end
