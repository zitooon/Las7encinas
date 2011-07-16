class AddIsAdminToInvitations < ActiveRecord::Migration
  def self.up
    add_column :invitations, :is_admin, :boolean
  end

  def self.down
    remove_column :invitations, :is_admin
  end
end
