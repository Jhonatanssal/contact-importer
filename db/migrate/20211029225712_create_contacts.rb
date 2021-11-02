# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string      :name,              null: false, default: ""
      t.date        :date_of_birth,     null: false, default: ""
      t.string      :phone,             null: false, default: ""
      t.string      :address,           null: false, default: ""
      t.string      :credit_card,       null: false, default: ""
      t.string      :franchise,         null: false, default: ""
      t.string      :email,             null: false, default: ""
      t.references  :user,              null: false, foreign_key: true

      t.timestamps
    end
  end
end
