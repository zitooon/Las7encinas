class DropRequestsTable < ActiveRecord::Migration
  def self.up
    drop_table :requests
  end

  def self.down
    create_table :requests do |t|
      t.string :full_name
      t.string :phone
      t.string :email
      t.text :message
      t.string :company

      t.timestamps
    end
  end
end
