# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserFilesController, type: :request do
  describe "GET /new" do
    before do
      sign_in user
      get "/users/#{user.id}/user_files/new"
    end

    let(:user) { create(:user) }
    let(:user_file) { create(:user_file, user_id: user.id) }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "has a form" do
      expect(response.body).to match("Name")
      expect(response.body).to match("Email")
      expect(response.body).to match("Address")
    end
  end
end
