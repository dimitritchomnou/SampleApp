class Micropost < ActiveRecord::Base

	belongs_to :user #Un micro messg appartient à un user
	#default_scope :order  => 'microposts.created_at DESC' #classement des micro_messages du plus recent au plus vieux
	default_scope -> { order('created_at DESC') }
	# Retourne les micro-messages des utilisateurs suivi par un utilisateur donné.
	scope :from_users_followed_by, lambda { |user| followed_by(user) }




	#validations du modèle Micropost
	validates :user_id, :presence  => true
	validates :content, :presence => true, :length => { :maximum => 140 }


	def self.from_users_followed_by(user)
	    followed_ids = user.following.map(&:id).join(", ")
	    where("user_id IN (#{followed_ids}) OR user_id = ?", user)
	end

	private
		# Retourne une condition SQL pour les utilisateurs suivis par un utilisateur donné.
   		# Nous incluons aussi les propres micro-messages de l'utilisateur.
   		def self.followed_by(user)
   			followed_ids = %(SELECT followed_id FROM relationships
                       WHERE follower_id = :user_id)
            where("user_id IN (#{followed_ids}) OR user_id = :user_id",
            { :user_id => user })
    	end

	
end
