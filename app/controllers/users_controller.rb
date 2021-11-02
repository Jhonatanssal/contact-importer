# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = current_user
    @contacts = @user.contacts
    @files = @user.user_files
  end
end
