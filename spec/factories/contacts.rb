# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    name { Faker::Name.first_name }
    address { Faker::Address.street_address }
    email { Faker::Internet.email }
    date_of_birth { Faker::Date.between(from: 30.years.ago, to: Date.today) }
    phone { "(+57) 333 444 55 66" }
    credit_card { Faker::Finance.credit_card(:mastercard) }
    franchise { "maestro" }
    user

    trait :mastercard do
      credit_card { Faker::Finance.credit_card(:mastercard) }
      franchise { "maestro" }
    end

    trait :visa do
      credit_card { Faker::Finance.credit_card(:visa) }
      franchise { "visa" }
    end
  end
end
