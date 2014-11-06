class Receiver < ActiveRecord::Base
  belongs_to :mailbox
  belongs_to :email

  # FIXME_AK: Pls the explain the following conditions.
  before_save :receivers_count, if: -> { email_id? }
  after_save :save_contact_in_receiver, if: -> { mailbox_id? }

  private

  def receivers_count
    # FIXME_AK: What is the purpose of this check?
    email.receivers.count < 20
  end

  def save_contact_in_receiver
    mailbox.contacts.create(contact_params)
  end

  # FIXME_AK: What is the purpose of this method?
  def contact_params
    { first_name: contact_mailbox.name, contact_mailbox_id: contact_mailbox.id }
  end

end
