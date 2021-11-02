class CreateRejectedContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :rejected_contacts do |t|
      t.string :contact_name
      t.string :contact_email
      t.text :reasons
      t.references :user, null: false, foreign_key: true
      t.references :user_file, null: false, foreign_key: true

      t.timestamps
    end
  end
end
