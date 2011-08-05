class RenameUserToOwnerOrClient < ActiveRecord::Migration
  def self.up
    rename_column :delivery_addresses, :user_id, :client_id
    rename_column :lines, :user_id, :client_id
    rename_column :searches, :user_id, :client_id
    rename_column :shops, :user_id, :owner_id
  end

  def self.down
    rename_column :shops, :owner_id, :user_id
    rename_column :searches, :client_id, :user_id
    rename_column :lines, :client_id, :user_id
    rename_column :delivery_addresses, :client_id, :user_id
  end
end
