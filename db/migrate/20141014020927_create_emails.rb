class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :filename
      t.string :content
      t.text :subject
      t.references :mailbox, index: true
      t.references :email, index: true
      t.boolean :spam, default: false
      t.timestamps
    end
  end
end
