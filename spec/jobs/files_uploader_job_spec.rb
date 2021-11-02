# frozen_string_literal: true

require "rails_helper"

RSpec.describe FilesUploaderJob, type: :job do
  describe "#perform_later" do
    it "enqueues a new job" do
      ActiveJob::Base.queue_adapter = :test
      expect do
        FilesUploaderJob.perform_later
      end.to have_enqueued_job
    end
  end
end
