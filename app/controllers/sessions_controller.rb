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

  # def create
  #   user = User.authenticate(params[:session][:password], 
  #                            params[:session][:password])
  #   if user
  #     sign_in user
  #     redirect_back_or user
  #   else
  #     #Flash d'erreur'
  #     flash.now[:error] = "Combinaison email/mot de passe invalide!"
  #     @titre = "S'identifier"
  #     render 'new'
  #   end
    
  # end



  #detruire une session
  def destroy
    
  	sign_out
  	#redirection vers la page index
  	redirect_to root_path
  end
end
