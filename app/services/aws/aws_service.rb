# frozen_string_literal: true

module Aws
  class AwsService
    def upload(file)
      s3 = Aws::S3::Resource.new.bucket(Rails.application.credentials.aws[:bucket])
      path = "jhonatan/test/user_files/#{file.original_filename}"
      obj =  s3.object(path)

      obj.upload_file(file)
      obj
    end
  end
end
