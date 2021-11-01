# frozen_string_literal: true

class UserFilesController < ApplicationController
  def new
    @user_file = UserFile.new
  end

  def create
    @user_file = UserFile.new(
      url: aws_object.public_url,
      name: aws_object.key,
      user: current_user
    )

    if @user_file.save
      redirect_to user_path(current_user), success: "File successfully uploaded"
    else
      flash.now[:notice] = "There was an error"
      render :new
    end
  end

  def show
    @file = UserFile.includes(:contacts).find(params[:id])
    @contacts = @file.contacts
  end

  private

  def aws_object
    Aws::AwsService.new.upload(params[:user_file][:file])
  end
end
