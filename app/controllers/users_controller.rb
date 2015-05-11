class UsersController < ApplicationController
  
  #Action pour Unscription d'un User
  def new
  	@titre = "Inscription"
  end

  #Action pour afficher un Users
  def show
    @user = User.find(params[:id])
  end

end
