# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize

class UserFilesController < ApplicationController
  def new
    @user_file = UserFile.new
    @columns = [
      ["Column 1", 0],
      ["Column 2", 1],
      ["Column 3", 2],
      ["Column 4", 3],
      ["Column 5", 4],
      ["Column 6", 5],
      ["Column 7", 6]
    ]
  end

  def create
    aws = aws_object(params[:user_file][:file])
    @user_file = UserFile.new(url: aws.public_url, name: aws.key, user: current_user)

    if @user_file.save
      FilesUploaderJob.perform_later(file_params[:columns], parse_csv(file_params[:file]),
                                     current_user.id, @user_file.id)
      redirect_to user_path(current_user), success: "File successfully uploaded"
    else
      flash.now[:notice] = "There was an error"
      render :new
    end
  end

  def show
    @file = UserFile.includes(:contacts, :rejected_contacts).find(params[:id])
    @contacts = @file.contacts
    @rejected_contacts = @file.rejected_contacts
  end

  private

  def aws_object(file)
    Aws::AwsService.new.upload(file)
  end

  def parse_csv(file)
    require "csv"

    CSV.open(file, headers: :first_row).map(&:to_h)
  end

  def file_params
    params.require(:user_file).permit(
      :file,
      columns: %i[contact_name email phone address date_of_birth credit_card franchise]
    )
  end
end

# rubocop:enable Metrics/AbcSize
