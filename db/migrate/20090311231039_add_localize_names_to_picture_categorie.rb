class AddLocalizeNamesToPictureCategorie < ActiveRecord::Migration
  def self.up
    add_column :picture_categories, :name_es, :string
    add_column :picture_categories, :name_fr, :string
    rename_column :picture_categories, :name, :name_en
  end

  def self.down
    rename_column :picture_categories, :name_en, :name
    remove_column :picture_categories, :name_fr
    remove_column :picture_categories, :name_es
  end
end
