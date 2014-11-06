class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.integer :phone_number
      t.string :address
      t.references :mailbox, index: true
      t.references :contact_mailbox
      t.timestamps
    end
  end
end
