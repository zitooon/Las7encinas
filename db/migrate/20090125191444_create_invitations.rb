class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.string :code
      t.text :comment
      t.integer :nb_connections, :default => 0
      t.integer :nb_pages_seen, :default => 0
      t.datetime :expires_at

      t.timestamps
    end
  end

  def self.down
    drop_table :invitations
  end
end
