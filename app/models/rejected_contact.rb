# frozen_string_literal: true

class RejectedContact < ApplicationRecord
  belongs_to :user
  belongs_to :user_file

  validates :user_id, presence: true
  validates :user_file_id, presence: true
end
