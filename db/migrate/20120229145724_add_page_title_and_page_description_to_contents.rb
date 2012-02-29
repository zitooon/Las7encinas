class AddPageTitleAndPageDescriptionToContents < ActiveRecord::Migration
  def self.up
    add_column :contents, :page_title_fr, :string
    add_column :contents, :page_description_fr, :string
    add_column :contents, :page_title_es, :string
    add_column :contents, :page_description_es, :string
    add_column :contents, :page_title_en, :string
    add_column :contents, :page_description_en, :string
  end

  def self.down
    remove_column :contents, :page_title_fr, :string
    remove_column :contents, :page_description_fr, :string
    remove_column :contents, :page_title_es, :string
    remove_column :contents, :page_description_es, :string
    remove_column :contents, :page_title_en, :string
    remove_column :contents, :page_description_en, :string
  end
end
