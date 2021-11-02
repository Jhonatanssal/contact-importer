# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserFiles::FileUploadService, type: :job do
  describe "#call" do
    let(:user) { create(:user) }
    let(:user_file) { create(:user_file) }
    let(:books) do
      [
        {
          contact_name: "Test-1",
          phone: "(+57) 111 222 33 44",
          address: "Street 111",
          email: Faker::Internet.email,
          date_of_birth: "1999/01/01",
          creadit_card: Faker::Finance.credit_card(:mastercard),
          franchise: "maestro"
        }
      ]
    end
    let(:columns) do
      {
        contact_name: "0",
        email: "3",
        phone: "1",
        address: "2",
        date_of_birth: "4",
        credit_card: "5",
        franchise: "6"
      }
    end

    describe "contacts creation" do
      subject { described_class.new(columns, books, user.id, user_file.id) }

      it { expect { subject.call }.to change(Contact, :count).by(1) }
    end

    describe "rejected contacts creation" do
      subject { described_class.new(columns, books, user.id, user_file.id) }
      let(:contact) { Contact.last }

      it { expect { subject.call }.to change(RejectedContact, :count).by(1) }
    end
  end
end
