# frozen_string_literal: true

require "rails_helper"

RSpec.describe RejectedContact, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:user_file) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:user_file_id) }
  end
end
