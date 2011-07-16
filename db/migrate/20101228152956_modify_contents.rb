class ModifyContents < ActiveRecord::Migration
  def self.up
    rename_column :contents, :title, :title_en
    rename_column :contents, :text, :text_en
    remove_column :contents, :lang
    
    add_column :contents, :title_es, :string   
    add_column :contents, :text_es, :text   

    add_column :contents, :title_fr, :string   
    add_column :contents, :text_fr, :text   
  end

  def self.down
    rename_column :contents, :title_en, :title
    rename_column :contents, :text_en, :text
    add_column :contents, :lang, :limit => 3
    
    remove_column :contents, :title_es   
    remove_column :contents, :text_es   

    remove_column :contents, :title_fr   
    remove_column :contents, :text_fr
  end
end
