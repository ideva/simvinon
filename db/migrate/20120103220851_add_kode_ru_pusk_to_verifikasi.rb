class AddKodeRuPuskToVerifikasi < ActiveRecord::Migration
  def self.up
    add_column :verifikasis, :kode_ru_pusk, :string
  end

  def self.down
    remove_column :verifikasis, :kode_ru_pusk
  end
end
