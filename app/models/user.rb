class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'

  def to_s
    email
  end

  def received_messages
    Message.where(recipient: self).order(created_at: :desc)
  end

  def sent_messages
    Message.where(sender: self).order(created_at: :desc)
  end

  def latest_received_messages(n)
    received_messages.order(created_at: :desc).limit(n)
  end

  def unread_messages
    received_messages.unread
  end

end
