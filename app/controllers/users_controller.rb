class UsersController < ApplicationController
  #respond_to :html, :js


  #restreindre l'action edit et update avant tte action du contrôleur
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  before_filter :authenticate, :except => [:show, :new, :create]




  #Action pour les suivi
  def following
    @titre = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  #Action pour lecteurs
  def followers
    @titre = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end

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
    @microposts = @user.microposts.paginate(:page => params[:page])
    @titre = @user.nom

    #format pour Pdf
    # respond_to do |format|
    #   format.html{ render :show }
    #   format.pdf {
    #     render :pdf => "show", :layout => 'pdf.html'
    #   }
    # end
  end

  #Creation d'un new User
  def create
  	@user = User.new(user_params)
  	if @user.save

      #validation pour envoi de mail
      #avec la methode deliver_now
      UserMailer.welcome_email(@user).deliver_now

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

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
