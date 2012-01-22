class AddControllerNameToFunction < ActiveRecord::Migration
  def self.up
    add_column :functions, :controller_name, :string
  end

  def self.down
    remove_column :functions, :controller_name
  end
end
