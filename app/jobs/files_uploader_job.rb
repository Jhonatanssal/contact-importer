# frozen_string_literal: true

class FilesUploaderJob < ApplicationJob
  queue_as :default

  def perform(columns, file, user_id, user_file)
    UserFiles::FileUploadService.new(
      columns: columns,
      file: file,
      user_id: user_id,
      user_file: user_file
    ).call
  end
end
