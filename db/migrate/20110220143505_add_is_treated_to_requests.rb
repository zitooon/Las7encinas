class AddIsTreatedToRequests < ActiveRecord::Migration
  def self.up
    add_column :requests, :is_treated, :boolean, :default => true
  end

  def self.down
    remove_column :requests, :is_treated
  end
end
