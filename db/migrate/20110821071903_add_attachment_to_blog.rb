class AddAttachmentToBlog < ActiveRecord::Migration
  def self.up
    add_column :blogs, :attachment, :string
  end

  def self.down
    remove_column :blogs, :attachment
  end
end
