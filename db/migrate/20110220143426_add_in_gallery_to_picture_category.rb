class AddInGalleryToPictureCategory < ActiveRecord::Migration
  def self.up
    add_column :picture_categories, :in_gallery, :boolean
  end

  def self.down
    remove_column :picture_categories, :in_gallery
  end
end
