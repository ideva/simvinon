class AddEjkbmToVerifikasi < ActiveRecord::Migration
  def self.up
    add_column :verifikasis, :no_ejkbm, :string
  end

  def self.down
    remove_column :verifikasis, :no_ejkbm
  end
end
