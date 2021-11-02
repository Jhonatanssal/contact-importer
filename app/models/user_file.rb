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
    state :failed
    state :terminated

    event :process do
      transitions from: :on_hold, to: :processing
    end

    event :fail do
      transitions from: :processing, to: :failed
    end

    event :finish do
      transitions from: :processing, to: :terminated
    end
  end

  def csv_file_url
    return unless resume.attached?

    resume.blob.service_url
  end
end
