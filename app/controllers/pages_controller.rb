class PagesController < ApplicationController
  
  #controller home 
  def home
  	@titre = "Accueil"
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
