class CreateVerifikasiToEjkbmFirsts < ActiveRecord::Migration
  def self.up
    create_table :verifikasi_to_ejkbm_firsts do |t|
      t.text :post_param
      t.boolean :sent_to_ejkbm

      t.timestamps
    end
  end

  def self.down
    drop_table :verifikasi_to_ejkbm_firsts
  end
end
