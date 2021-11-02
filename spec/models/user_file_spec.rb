# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserFile, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:user_id) }
  end

  describe "instance methods" do
    describe "#download_url" do
      subject { create(:user_file) }

      it { is_expected.to respond_to(:download_url) }
    end
  end
end
