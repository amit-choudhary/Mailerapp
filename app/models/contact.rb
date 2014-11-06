class Contact < ActiveRecord::Base
  belongs_to :mailbox
  belongs_to :contact_mailbox, class_name: 'Mailbox', foreign_key: 'contact_mailbox_id'

  before_create :set_first_name, unless:-> { first_name? }

  validates :contact_mailbox_id, uniqueness: { scope: :mailbox_id }

  private

  def set_first_name_if_unavailable
    self.first_name = contact_mailbox.name
  end

end
