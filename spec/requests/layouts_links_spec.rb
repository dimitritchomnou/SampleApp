require 'rails_helper'

RSpec.describe "LayoutsLinks", type: :request do
  describe "GET /layouts_links" do
    it "works! (now write some real specs)" do
      get layouts_links_index_path
      expect(response).to have_http_status(200)
    end

    it "devrait avoir une page d'inscription a '/signup'" do
    	get '/signup'
    	response.should have_selector('title', :content => "Inscription")
	  end

    #Test Route pour la page Accueil
    it "devrait trouver la page  Accueil à '/'" do
      get 'pages/home'
      response.should have_selector('title', :content => "Accueil" )
    end

    #Test Route pour la page Contact
    it "devrait trouver la page  Contact à 'pages/contact'" do
      get 'pages/contact'
      response.should have_selector('title', :content => "Contact" )
    end

    #Test Route pour la page  A propos Apropos de  
    it "devrait trouver la page  Accueil à 'pages/about'" do
      get 'pages/about'
      response.should have_selector('title', :content => "A Propos" )
    end

    #Test Route pour la page Accueil
    it "devrait trouver la page  Accueil à 'pages/help'" do
      get 'pages/help'
      response.should have_selector('title', :content => "Aide" )
    end

  end
end
