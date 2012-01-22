class AddIsActiveToLCountry < ActiveRecord::Migration
  def self.up
    add_column :l_countries, :is_active, :boolean, :default => true
  end

  def self.down
    remove_column :l_countries, :is_active
  end
end
