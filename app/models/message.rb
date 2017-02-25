class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  # scope method for short scopes like this
  scope :unread, -> { where(read_at: nil) }

  # the same as above

  # def self.unread
  #   where(read_at: nil)
  # end

  def mark_as_read!
    self.read_at = Time.now
    save!
  end

  def read?
    read_at
  end
end
