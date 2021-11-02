# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contacts
  has_many :user_files

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, format: { with: /\A[a-zA-Z0-9]+\z/, message: "must be alphanumeric" }
end
