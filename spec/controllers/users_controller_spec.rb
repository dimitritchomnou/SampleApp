require 'rails_helper'

#Permet de verifier si l'action new reponde
#A la requête GET
RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
