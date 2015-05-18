class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps null: false
    end
    #Ajout d'indexation à la table
    add_index :relationships, :follower_id
   	add_index :relationships, :followed_id
   	add_index :relationships, [:follower_id, :followed_id], :unique => true
  end

  def self.down
  	drop_table :relationships
  end
end
