class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.string :full_name
      t.string :phone
      t.string :email
      t.text :message
      t.string :company

      t.timestamps
    end
  end

  def self.down
    drop_table :requests
  end
end
