class AddIdCountryToLCity < ActiveRecord::Migration
  def self.up
    add_column :l_cities, :idcountry, :integer
  end

  def self.down
    remove_column :l_cities, :idcountry
  end
end
