class Contact < ActiveRecord::Base
  belongs_to :mailbox
  belongs_to :contact_mailbox, class_name: 'Mailbox', foreign_key: 'contact_mailbox_id'

  before_create :set_first_name, unless: -> { first_name? }
  # FIXME_AK: No validation on phone_number, etc.
  # FIXME_AK: Pls explain the purpose of the below validation.
  validates :contact_mailbox_id, uniqueness: { scope: :mailbox_id }

  private

  def set_first_name_if_unavailable
    self.first_name = contact_mailbox.name
  end

end
