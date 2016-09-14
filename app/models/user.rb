class User < ApplicationRecord
  has_many :messages_received, class_name: 'Message', foreign_key: :receiver_id
  has_many :messages_sent, class_name: 'Message', foreign_key: :sender_id
  before_save :email_downcase
  after_create :set_messages
  scope :for_collection_select, ->(email) do
    where.not(email: email)
         .where('messages_received_count < ? ', Message::WIN_PRIZE_AMOUNT)
         .order(:email)
  end
  scope :prize_hit_today, -> {where("prize_hit_at >= ? ", Time.zone.now - 24.hours)}

  INITIAL_MESSAGE_AMOUNT = 3.freeze

  def has_messages_remaining?
    return true if messages_remaining > 0
    false
  end

  def messages
    Message.where("sender_id = ? OR receiver_id = ?", self.id, self.id)
  end

  def get_messages
    messages.map{|message| message.get_node_with_people}
  end

  def get_messages_with_random(number)
    user_messages = messages.map{|message| message.get_node_with_people}
    user_message_ids = user_messages.map{|v| v[:id]}
    random_messages = Message.get_random(number - user_message_ids.count)
                        .reject{|v| v if user_message_ids.include?(v[:id])}.compact
    user_messages + random_messages
  end

  private
  def set_messages
    self.messages_remaining = INITIAL_MESSAGE_AMOUNT
  end

  def email_downcase
    self.email = self.email.downcase
  end

end
