class Attachment < ActiveRecord::Base

  belongs_to :email
  
  scope :videos, -> { where(type: 'Video')}
  scope :audios, -> { where(type: 'Audio')}
  scope :zips, -> { where(type: 'Zip')}
  scope :texts, -> { where(type: 'Text')}

  before_save :set_email_as_spam, if: -> { type == 'Text' }

  private

  def set_email_as_spam
   self.email.update_column('spam', true)
  end

end
