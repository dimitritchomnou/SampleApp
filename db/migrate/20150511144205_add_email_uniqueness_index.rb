class AddEmailUniquenessIndex < ActiveRecord::Migration
  def self.up
  	#ajout d'index au champs email
  	add_index :users, :email, :unique => true
  end

  def self.down
  	remove_index :users, :email
  end
end
