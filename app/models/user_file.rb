# frozen_string_literal: true

class UserFile < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :contacts

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
end
