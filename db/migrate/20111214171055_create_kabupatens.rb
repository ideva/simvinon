class CreateKabupatens < ActiveRecord::Migration
  def self.up
    create_table :kabupatens do |t|
      t.string :kode
      t.string :nama

      t.timestamps
    end
  end

  def self.down
    drop_table :kabupatens
  end
end
