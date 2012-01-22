class AddFlashNewsToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :flash_news, :text
  end

  def self.down
    remove_column :pages, :flash_news
  end
end
