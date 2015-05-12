class UsersController < ApplicationController
  
  #Action pour Unscription d'un User
  def new
  	#Affiche notre form d'insrciption
  	@user = User.new
  	@titre = "Inscription"
  end

  #Action pour afficher un Users
  def show
    @user = User.find(params[:id])
    @titre = @user.nom
  end

  #Creation d'un new User
  def create
  	@user = User.new(user_params)
  	if @user.save
  		#enregistrement
  		flash[:success] = "Bienvenue dans l'application exemple!"
  		redirect_to @user
  	else
  		@titre = "Inscription"
  		render 'new' 		
  	end 	
  end

  def user_params
     params[:user].permit :nom, :password, :email, :password_confirmation
  end

end
