class AddUniquenessByEmailAndSaltToUsers < ActiveRecord::Migration
  def self.up
    add_index :users, :email, :unique => true
    add_column :users, :salt, :string
  end

  def self.down
    remove_index :users, :email
    remove_column :users, :salt
  end
end
