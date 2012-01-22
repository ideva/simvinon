class AddAllowCommentToBlog < ActiveRecord::Migration
  def self.up
    add_column :blogs, :allow_comment, :boolean
  end

  def self.down
    remove_column :blogs, :allow_comment
  end
end
