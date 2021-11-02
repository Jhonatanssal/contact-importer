# frozen_string_literal: true

FactoryBot.define do
  factory :rejected_contact do
    contact_name { "Test 1" }
    contact_email { "Test 2" }
    reasons { "Errors Errors" }
    user_file { create(:user_file, user_id: user.id) }
    user
  end
end
