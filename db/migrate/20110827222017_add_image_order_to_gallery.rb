class AddImageOrderToGallery < ActiveRecord::Migration
  def self.up
    add_column :galleries, :image_order, :integer
  end

  def self.down
    remove_column :galleries, :image_order
  end
end
