class PagesController < ApplicationController
  def home
  	@titre = "Accueil"
  end

  def contact
  	@titre = "contact"
  end

  #controller about!
  def about
  	@titre = "A propos de"
  end
end
