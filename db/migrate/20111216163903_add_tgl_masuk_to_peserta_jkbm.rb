class AddTglMasukToPesertaJkbm < ActiveRecord::Migration
  def self.up
    add_column :peserta_jkbms, :tgl_masuk, :timestamp
  end

  def self.down
    remove_column :peserta_jkbms, :timestamp
  end
end
