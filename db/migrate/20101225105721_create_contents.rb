class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents, :force => true do |t|
      t.string   :symbol
      t.string   :lang, :limit => 3
      t.string   :title
      t.text     :text
      t.timestamps
    end    
  end

  def self.down
    drop_table :contents
  end
end
