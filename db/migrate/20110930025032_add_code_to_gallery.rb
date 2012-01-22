class AddCodeToGallery < ActiveRecord::Migration
  def self.up
    add_column :galleries, :code, :string
  end

  def self.down
    remove_column :galleries, :code
  end
end
