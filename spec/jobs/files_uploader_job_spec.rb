# frozen_string_literal: true

require "rails_helper"

RSpec.describe FilesUploaderJob, type: :job do
  include ActiveJob::TestHelper

  describe "#perform_later" do
    subject { FilesUploaderJob.perform_later(columns, books, user.id, user_file) }

    before { ActiveJob::Base.queue_adapter = :test }

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

    it "enqueues a new job" do
      expect { subject }.to have_enqueued_job
    end

    it "calls fileUploader" do
      expect_any_instance_of(UserFiles::FileUploadService).to receive(:call)

      perform_enqueued_jobs { subject }
    end
  end
end
