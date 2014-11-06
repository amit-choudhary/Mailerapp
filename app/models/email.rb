# FIXME_AK: No validations of any sort?
class Email < ActiveRecord::Base

  belongs_to :mailbox
  belongs_to :parent_email, class_name: :Email
  belongs_to :sending_mailbox, class_name: Mailbox, foreign_key: :mailbox_id
  
  has_many :replies, class_name: :Email, dependent: :destroy
  has_many :receivers, dependent: :destroy
  has_many :receiving_mailboxes, source: :mailbox, through: :receivers
  has_many :attachments, dependent: :destroy

  before_create :set_subject, unless: -> { subject? }
  before_save :check_mailbox_count, if: -> { mailbox_id? }

  after_create :enter_log_record

  private

  def set_subject
    self.subject = 'No Subject'
  end

  def check_mailbox_count
    sending_mailbox.sent_emails.count < 10
  end

  def enter_log_record
    Log.create(description: "An email with email id #{ id } has been sent from a mailbox with mailbox id #{ mailbox_id }")
  end

end
