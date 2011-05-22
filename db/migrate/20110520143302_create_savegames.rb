class CreateSavegames < ActiveRecord::Migration
  def self.up
    create_table :savegames do |t|
      t.string :name
      t.string :description
      t.integer :user_id

      t.timestamps
    end
    
    add_index :savegames, :user_id
  end

  def self.down
    drop_table :savegames
  end
end
