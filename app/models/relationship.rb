class Relationship < ActiveRecord::Base
	#création d'une relationship avec un att accessible
	#attr_accessible :followed_id


	#Ajout des association belongs_to au modèle 'Relationship'
	belongs_to :follower, :class_name => "User" #belong_to appartient à
	belongs_to :followed, :class_name => "User"

	#Ajout des validations du modèle 'Relationship'
	validates :follower_id, :presence => true 
	validates :followed_id, :presence => true

end
