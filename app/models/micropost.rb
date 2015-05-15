class Micropost < ActiveRecord::Base

	belongs_to :user #Un micro messg appartient à un user
	#default_scope :order  => 'microposts.created_at DESC' #classement des micro_messages du plus recent au plus vieux
	default_scope -> { order('created_at DESC') }

	#validations du modèle Micropost
	validates :user_id, :presence  => true
	validates :content, :presence => true, :length => { :maximum => 140 }

	
end
