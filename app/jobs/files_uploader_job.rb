# frozen_string_literal: true

class FilesUploaderJob < ApplicationJob
  queue_as :default

  def perform(columns, file, user_id, file_id)
    UserFiles::FileUploadService.new(columns, file, user_id, file_id).call
  end
end
