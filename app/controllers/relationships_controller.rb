class RelationshipsController < ApplicationController
	before_filter :authenticate

	def create
		@user = User.find(params[:relationship][:followed_id])
		current_user.follow!(@user)
		#redirect_to @user
		#reponse a une requête Ajax 
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end

	def destroy
		@user = relationship.find(params[:id]).followed
		current_user.unfollow!(@user)
		#redirect_to @user
		#reponse a une requete ajax
		respond_to do |format|
			format.html{ redirect_to @user }
			format.js
		end
	end
end
