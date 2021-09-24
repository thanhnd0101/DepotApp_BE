require 'rails_helper'

RSpec.describe Dam, type: :requet do
  include Rack::Test::Methods

  def app
    Dam.new
  end

  let!(:request) do
    -> { rails_respond_without_detailed_exceptions { get "/bad/path" } }
  end

  describe "Get list of document from /api/dam" do
    it "return list of documents" do
      document = Document.create!(title: "My Book Title",
                       description: "yyy",
                       image_url: "zzz.jpg",
                       price: 123123)
      header 'Content-Type', 'application/json'
      get "api/dam"
      puts last_response.body
      expect(last_response.body).to equal document.to_json
    end
  end
end
