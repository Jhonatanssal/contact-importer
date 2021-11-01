# frozen_string_literal: true

class CreateUserFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_files do |t|
      t.references :user, null: false, foreign_key: true
      t.string     :aasm_state

      t.timestamps
    end
  end
end
