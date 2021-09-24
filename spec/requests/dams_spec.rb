require 'rails_helper'

RSpec.describe "Dams", type: :request do
  describe "GET /dams" do
    it "works! (now write some real specs)" do
      get dams_path
      expect(response).to have_http_status(200)
    end
  end
end
