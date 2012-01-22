class AddCounterToBlog < ActiveRecord::Migration
  def self.up
    add_column :blogs, :counter, :integer
  end

  def self.down
    remove_column :blogs, :counter
  end
end
