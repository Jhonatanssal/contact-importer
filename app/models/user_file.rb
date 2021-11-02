# frozen_string_literal: true

class UserFile < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :contacts
  has_many :rejected_contacts

  has_one_attached :csv_file

  attr_reader :contact_name, :email, :phone, :address, :date_of_birth, :credit_card, :franchise

  validates :user_id, presence: true

  aasm do
    state :on_hold, initial: true
    state :processing
    state :terminated

    event :process do
      transitions from: :on_hold, to: :processing
    end

    event :finish do
      transitions from: :processing, to: :terminated
    end
  end

  def download_url
    presigner = Aws::S3::Presigner.new
    presigner.presigned_url(
      :get_object,
      bucket: Rails.application.credentials.aws[:bucket],
      key: name,
      expires_in: 7.days.to_i,
      response_content_disposition: "attachment; filename=\"#{name.split('/').last}\""
    ).to_s
  end
end
