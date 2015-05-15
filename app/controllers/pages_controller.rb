class PagesController < ApplicationController
  
  #controller home 
  def home
  	@titre = "Accueil"

    if signed_in?
      #crée un Micropost
      @micropost = Micropost.new 
      @feed_items = current_user.feed.paginate(:page => params[:page])
    end
  end

  #controller contact
  def contact
  	@titre = "contact"
  end

  #controller about!
  def about
  	@titre = "A propos de"
  end

  #controller help
  def help
    @titre = "aide"
  end
end
