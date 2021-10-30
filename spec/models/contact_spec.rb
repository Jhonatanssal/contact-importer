# frozen_string_literal: true

require "rails_helper"

RSpec.describe Contact, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    describe "presence" do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:date_of_birth) }
      it { is_expected.to validate_presence_of(:credit_card) }
      it { is_expected.to validate_presence_of(:address) }
      it { is_expected.to validate_presence_of(:user_id) }
    end

    describe "uniqueness" do
      subject { create(:contact) }

      it { is_expected.to validate_uniqueness_of(:email).scoped_to(:user_id) }
    end

    describe "formats" do
      context "with invalid values" do
        let(:contact) { create(:contact) }

        it "has invalid name" do
          contact.name = "Test 1"
          expect(contact).not_to be_valid
        end

        it "has invalid email" do
          contact.email = "test.co"
          expect(contact).not_to be_valid
        end

        it "has invalid date of birth" do
          contact.date_of_birth = "01 01 2001"
          expect(contact).not_to be_valid
        end

        it "has invalid credit card number" do
          contact.date_of_birth = "12345678910111"
          expect(contact).not_to be_valid
        end
      end
    end
  end
end
