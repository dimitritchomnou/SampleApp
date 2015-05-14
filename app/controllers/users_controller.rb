class UsersController < ApplicationController
  #restreindre l'action edit et update avant tte action du contrôleur
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy


  #suppression des users
  def destroy
    @titre = "supprimer"
    User.find(params[:id]).destroy
    flash[:success] = "utilisateurs supprimé."
    redirect_to users_path
  end
  
  def index
    @titre = "Tous les utilisateurs"
    #@users = User.all
     @users = User.paginate(:page => params[:page])
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
  		@titre = "Sign up"
  		render 'new' 		
  	end 	
  end


  def edit
    @user = User.find(params[:id])
    @titre = "Édition profil"
  end

  #Modification du user
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params.require(:user).permit(:password, :password_confirmation))
      flash[:success] = "Profil actualisé."
      redirect_to @user
    else
      @titre = "Édition profil"
      render 'edit'
    end
  end

  private
    def user_params
       #params[:user].permit :nom, :email, :password, :password_confirmation
       params.require(:user).permit :nom, :email, :password, :password_confirmation

    end
 

  private 
    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
