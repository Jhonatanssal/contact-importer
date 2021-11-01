# frozen_string_literal: true

require "rails_helper"

RSpec.describe ContactsController, type: :request do
  describe "GET /show" do
    before do
      sign_in user
      get "/users/#{user.id}/contacts/#{contact.id}"
    end

    let(:user) { create(:user) }
    let(:contact) { create(:contact, user_id: user.id) }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "has contact info" do
      expect(response.body).to match(contact.name)
      expect(response.body).to match(contact.email)
      expect(response.body).to match(contact.address)
    end
  end
end
