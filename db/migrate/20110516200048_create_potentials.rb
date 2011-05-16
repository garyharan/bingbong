class CreatePotentials < ActiveRecord::Migration
  def self.up
    create_table :potentials do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :phone
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :potentials
  end
end
