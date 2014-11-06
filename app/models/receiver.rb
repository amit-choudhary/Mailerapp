class Receiver < ActiveRecord::Base
  belongs_to :mailbox
  belongs_to :email

  before_save :receivers_count, if: -> { email_id? }
  after_save :save_contact_in_receiver, if: -> { mailbox_id? }

  private

  def receivers_count
    email.receivers.count < 20
  end

  def save_contact_in_receiver
    mailbox.contacts.create(contact_params)
  end

  def contact_params
    { first_name: contact_mailbox.name, contact_mailbox_id: contact_mailbox.id }
  end

end
