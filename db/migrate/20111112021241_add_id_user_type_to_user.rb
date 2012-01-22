class AddIdUserTypeToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :iduser_type, :integer
  end

  def self.down
    remove_column :users, :iduser_type
  end
end
