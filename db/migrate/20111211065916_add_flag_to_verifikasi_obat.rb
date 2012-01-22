class AddFlagToVerifikasiObat < ActiveRecord::Migration
  def self.up
    add_column :verifikasi_obats, :flag, :integer
  end

  def self.down
    remove_column :verifikasi_obats, :flag
  end
end
