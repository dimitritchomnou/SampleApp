class UsersController < ApplicationController
  #restreindre l'action edit et update avant tte action du contrôleur
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  
  def index
    @titre = "Tous les utilisateurs"
    @users = User.all
  end


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
      #identification du user après son inscription
      sign_in @user
  		#enregistrement
  		flash[:success] = "Bienvenue dans l'application exemple!"
  		redirect_to @user
  	else
  		@titre = "Inscription"
  		render 'new' 		
  	end 	
  end

  def edit
    #s@user = User.find(params[:id])
    @titre = "Edition profil"  
  end


  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "profil actualisé."
      redirect_to @user
    else
      @titre = "Edition profil"
      render 'edit'
    end
  end

  def user_params
     params[:user].permit :nom, :password, :email, :password_confirmation
  end


  private 
    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
