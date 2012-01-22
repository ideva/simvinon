class AddIsCoverToGallery < ActiveRecord::Migration
  def self.up
    add_column :galleries, :is_cover, :boolean
  end

  def self.down
    remove_column :galleries, :is_cover
  end
end
