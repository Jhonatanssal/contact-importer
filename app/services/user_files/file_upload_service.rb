# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize

module UserFiles
  class FileUploadService
    def initialize(columns, file, user_id, user_file)
      @file = file
      @user_id = user_id
      @user_file = user_file
      @columns = columns
    end

    def call
      iterate_array
    end

    private

    def iterate_array
      convert_hash_to_array.each do |row|
        create_contact(row)
      end
    end

    def convert_hash_to_array
      @file.map(&:values)
    end

    def create_contact(row)
      contact = Contact.create(name: row[@columns[:contact_name].to_i],
                               date_of_birth: row[@columns[:date_of_birth].to_i],
                               email: row[@columns[:email].to_i],
                               address: row[@columns[:address].to_i],
                               phone: row[@columns[:phone].to_i],
                               credit_card: row[@columns[:credit_card].to_i],
                               franchise: row[@columns[:franchise].to_i],
                               user_id: @user_id,
                               user_file_id: @user_file.id)

      contact_report(contact) unless contact.persisted?
    end

    def contact_report(contact)
      RejectedContact.create(
        contact_name: contact.name,
        contact_email: contact.email,
        user_file_id: contact.user_file_id,
        user_id: contact.user_id,
        reasons: errors_refactor(contact.errors)
      )

      @user_file.fail! unless @user_file.failed?
    end

    def errors_refactor(errors)
      response = ""
      errors.full_messages.each do |msg|
        response += "- #{msg}\n"
      end

      response
    end
  end
end

# rubocop:enable Metrics/AbcSize
