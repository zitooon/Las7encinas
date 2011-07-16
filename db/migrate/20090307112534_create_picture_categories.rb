class CreatePictureCategories < ActiveRecord::Migration
  def self.up
    create_table :picture_categories do |t|
      t.string :name
      t.integer :position, :default => 0
    end
  end

  def self.down
    drop_table :picture_categories
  end
end
