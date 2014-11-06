class Mailbox < ActiveRecord::Base
  has_many :receivers
  has_many :sent_emails, class_name: Email
  has_many :contacts
  has_many :friends, source: :contact_mailbox, through: :contacts
  has_many :received_emails, source: :email, through: :receivers

  before_destroy :check_if_spam_mailbox

  private
  
  def check_if_spam_mailbox
    received_emails.all?{ |email| email.spam }
  end
  
end
