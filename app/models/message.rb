class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id, counter_cache: :messages_sent_count
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id, counter_cache: :messages_received_count
  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :body, presence: true
  validates_associated :sender
  validates_associated :receiver
  validate :sender_is_not_receiver
  validate :sender_has_messages_to_send
  validate :receiver_can_receive
  after_create :send_message_mailer, :decrement_sender_remaining_messages, :check_if_prize_hit
  after_commit :display_message, on: [:create]
  scope :today, -> {where('created_at >= ?', Time.now - 24.hours)}
  scope :get_by_user, -> (user_id) do
    includes(:sender, :receiver)
      .where("sender_id = ? OR receiver_id = ?", user_id, user_id)
      .map{|message| message.get_node_with_people}
  end
  scope :get_random, -> (number) do
    includes(:sender, :receiver)
      .order("RANDOM()")
      .last(number).map{|message| message.get_node_with_people}
  end
  WIN_PRIZE_AMOUNT = 3.freeze

  def get_node
    {id: self.id, label: self.body}
  end

  def get_node_with_people
    {
      id: self.id,
      label: self.body,
      sender: {
        id: self.sender.id,
        email: self.sender.email,
        messages_sent_count: self.sender.messages_sent_count
      },
      receiver: {
        id: self.receiver.id,
        email: self.receiver.email,
        messages_sent_count: self.sender.messages_sent_count
      }
    }
  end

  def thank_you_message
    if self.sender.has_messages_remaining?
      return <<-eos
        <p>
          You've got #{self.sender.messages_remaining} more messages to send this week!.
        </p>
        <p>
          <a data-remote=true href=\'/messages/new\'>
            Send Another?
          </a>
        </p>
      eos
    else
      '<p>That was your last message for this period, send more next week!</p>'
    end
  end

  def get_time_sent
    created_at.localtime.strftime('%A, %B %e %Y, %I:%M %p')
  end


  private
    def display_message
      MessageDisplayJob.perform_async(self.id)
    end
    def sender_is_not_receiver
      errors.add(:base, "You can't send messages to yourself, even though you definitely deserve them!") if receiver_id == sender_id
    end

    def sender_has_messages_to_send
      if sender.messages_remaining <= 0
        errors.add(:base, "You've already sent all of your messages for this period!")
      end
    end

    def receiver_can_receive
      unless receiver.messages_received_count < WIN_PRIZE_AMOUNT
        errors.add(:base, "They've already received a gift, spread the messages around!")
      end
    end

    def send_message_mailer
      #MessagesMailer.delay.message_received(self.id) unless Rails.env.development?
      true
    end

    def decrement_sender_remaining_messages
      sender = self.sender
      sender.update(messages_remaining: sender.messages_remaining - 1)
    end

    def check_if_prize_hit
      if self.receiver.messages_received_count === WIN_PRIZE_AMOUNT
        self.receiver.update(prize_hit: true, prize_hit_at: Time.now)
      end
    end

end
