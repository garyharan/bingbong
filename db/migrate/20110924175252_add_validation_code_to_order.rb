class AddValidationCodeToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :validation_code, :text
  end

  def self.down
    remove_column :orders, :validation_code
  end
end
