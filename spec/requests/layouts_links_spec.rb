require 'rails_helper'

RSpec.describe "LayoutsLinks", type: :request do
  describe "GET /layouts_links" do
    it "works! (now write some real specs)" do
      get layouts_links_index_path
      expect(response).to have_http_status(200)
    end
  end
end
