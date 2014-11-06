class Attachment < ActiveRecord::Base

  belongs_to :email
  
  scope :videos, -> { where(type: 'Video')}
  scope :audios, -> { where(type: 'Audio')}
  scope :zips, -> { where(type: 'Zip')}
  scope :texts, -> { where(type: 'Text')}

  # FIXME_AK: Shouldn't this be done from the email side.
  # When we are saving the email, shouldn't the logic 
  # should mark it as spam, when there are any text attachment

  before_save :set_email_as_spam, if: -> { type == 'Text' }

  private

  def set_email_as_spam
   self.email.update_column('spam', true)
  end

end
