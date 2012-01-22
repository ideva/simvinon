class AddNoRegToVerifikasi < ActiveRecord::Migration
  def self.up
    add_column :verifikasis, :no_reg, :string
  end

  def self.down
    remove_column :verifikasis, :no_reg
  end
end
