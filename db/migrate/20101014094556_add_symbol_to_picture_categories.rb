class AddSymbolToPictureCategories < ActiveRecord::Migration
  def self.up
    add_column :picture_categories, :symbol, :string
  end

  def self.down
    remove_column :picture_categories, :symbol
  end
end
