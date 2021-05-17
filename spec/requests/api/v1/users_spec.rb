require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "GET /index" do
    it "Should return the users list" do
      get "/api/v1/users"
      expect(response.status).to eq(200)
    end
  end
end
