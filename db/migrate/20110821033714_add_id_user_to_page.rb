class AddIdUserToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :iduser, :integer, :default => 0
  end

  def self.down
    remove_column :pages, :iduser
  end
end
