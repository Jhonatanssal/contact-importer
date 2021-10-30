# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Alphanumeric.alpha(number: 10) }
    email { Faker::Internet.email }
    password { "Test1234" }
  end
end
