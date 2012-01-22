class CreateErrorTmps < ActiveRecord::Migration
  def self.up
    create_table :error_tmps do |t|
      t.text :error_msg

      t.timestamps
    end
  end

  def self.down
    drop_table :error_tmps
  end
end
