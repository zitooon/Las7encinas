class ModifyPictures < ActiveRecord::Migration
  def self.up
     rename_column :pictures, :comment, :comment_en
     add_column :pictures, :comment_es, :string   
     add_column :pictures, :comment_fr, :string   
   end

   def self.down
     rename_column :pictures, :comment_en, :comment
     remove_column :pictures, :comment_es
     remove_column :pictures, :comment_fr
   end
end