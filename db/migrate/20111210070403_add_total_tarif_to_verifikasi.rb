class AddTotalTarifToVerifikasi < ActiveRecord::Migration
  def self.up
    add_column :verifikasis, :total_tarif, :float, :default => 0
  end

  def self.down
    remove_column :verifikasis, :total_tarif
  end
end
