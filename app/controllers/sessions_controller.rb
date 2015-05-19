class SessionsController < ApplicationController

  def new
  	@titre = "S'identifier"
  end

  def create
  	user = User.authenticate(params[:session][:email],
  							             params[:session][:password])
  	if user.nil?
  		#Flash d'erreur
  		flash.now[:error] = "Combinaison email/mot de passe invalide!"
  		@titre = "S'identifier"
  		render 'new'

    else
  		#Authentification et redirection vers une autre page
  		sign_in user
  		#redirect_to user
      redirect_back_or user
  	end
  end

  #detruire une session
  def destroy
    
  	sign_out
  	#redirection vers la page index
  	redirect_to root_path
  end
end
