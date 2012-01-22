class CreateUserTypeFunctions < ActiveRecord::Migration
  def self.up
    create_table :user_type_functions do |t|
      t.integer :iduser_type
      t.integer :idfunction

      t.timestamps
    end
  end

  def self.down
    drop_table :user_type_functions
  end
end
