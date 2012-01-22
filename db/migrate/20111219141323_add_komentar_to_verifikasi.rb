class AddKomentarToVerifikasi < ActiveRecord::Migration
  def self.up
    add_column :verifikasis, :komentar, :text
  end

  def self.down
    remove_column :verifikasis, :komentar
  end
end
