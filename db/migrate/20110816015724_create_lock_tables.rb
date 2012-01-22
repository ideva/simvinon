class CreateLockTables < ActiveRecord::Migration
  def self.up
    create_table :lock_tables do |t|
      t.string :model
      t.integer :iduser_access
      t.string :session_id

      t.timestamps
    end
  end

  def self.down
    drop_table :lock_tables
  end
end
