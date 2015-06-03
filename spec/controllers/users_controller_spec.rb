require 'rails_helper'

#Permet de verifier si l'action new reponde
#A la requête GET
RSpec.describe UsersController, type: :controller do



	#Test la vue associée a l'action
	render_views

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end


    it "devrait avoir le titre adéquat" do
    	get 'new'
    	response.should have_selector("title", :content => "Inscription" )
	end
  end

end
