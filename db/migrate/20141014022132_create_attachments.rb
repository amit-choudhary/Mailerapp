class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :name
      t.string :type
      t.references :email, index: true
      t.timestamps
    end
  end
end
