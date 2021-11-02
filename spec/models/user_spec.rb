# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:contacts) }
    it { is_expected.to have_many(:user_files) }
  end

  describe "validations" do
    describe "presence" do
      it { is_expected.to validate_presence_of(:username) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:password) }
    end

    describe "uniqueness" do
      it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
      it { is_expected.to validate_uniqueness_of(:username) }
    end
  end
end
