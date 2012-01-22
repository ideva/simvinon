class AddSessionIdToGallery < ActiveRecord::Migration
  def self.up
    add_column :galleries, :session_id, :string
  end

  def self.down
    remove_column :galleries, :session_id
  end
end
