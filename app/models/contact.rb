# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :name, format: { with: /\A[a-zA-Z0-9\-]+\z/, message: "must be alphanumeric or with '-'" }
  validates :date_of_birth, presence: true
  validates :phone, presence: true
  validates :phone, format: {
    with: /\A\(\+\d{2}\)\s\d{3}[\- ]\d{3}[\- ]\d{2}[\- ]\d{2}\z/,
    message: "format must be (+00) 000 000 00 00 or (+00) 000-000-00-00"
  }
  validates :address, presence: true
  validates :credit_card, presence: true
  validates :franchise, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { scope: :user_id }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :user_id, presence: true

  validate :date_format
  validate :card_validation

  private

  def date_format
    return true if ymd_format(date_of_birth.to_s)

    add_phone_error
  end

  def ymd_format(date)
    begin
      ymd_format = Date.strptime(date, "%Y-%m-%d").instance_of?(Date)
    rescue TypeError, ArgumentError, Error
      return false
    end

    ymd_format
  end

  def card_validation
    detector = CreditCardValidations::Detector.new(credit_card)

    return add_card_error unless detector.valid_luhn?

    add_franchise(detector)
    true
  end

  def add_phone_error
    errors.add(:date_of_birth, "format must be 'Y-M-D' or 'Y/M/D.")
  end

  def add_card_error
    errors.add(:credit_card, "please enter a valid card number.")
  end

  def add_franchise(detector)
    self.franchise = detector.brand
  end
end
