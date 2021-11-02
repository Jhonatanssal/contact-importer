# frozen_string_literal: true

class AddUserFileReferenceToContact < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :user_file_id, :integer, default: ""
  end
end
