class RelationshipsController < ApplicationController
	before_filter :authenticate

	def create
		@user = User.find(params[:relationship][:followed_id])
		#@user = User.find(params[:followed_id])
		current_user.follow!(@user)
		#reponse a une requête Ajax 
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end

	def destroy
		@user = Relationship.find(params[:id]).followed
		current_user.unfollow!(@user)
		#redirect_to @user
		#reponse a une requete ajax
		respond_to do |format|
			format.html{ redirect_to @user }
			format.js
		end
	end
end
