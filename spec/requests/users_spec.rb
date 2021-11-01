# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "GET /show" do
    before do
      sign_in user
      get "/users/show"
    end

    let(:user) { create(:user) }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "has current user info" do
      expect(response.body).to match(user.username)
    end
  end
end
