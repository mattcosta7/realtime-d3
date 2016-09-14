class MessagesMailer < ApplicationMailer

  def message_received(message_id)
    @greeting = "Hi"
    @message = Message.find(message_id)
    @receiver = @mess.receiver
    @message = @message.message
    mail to: @receiver.email, subject: "Realtime D3 | You've been sent a message!"
  end

  def daily_update
    @greeting = "Hi"
    now = Time.now
    @messages = Message.includes(:sender, :receiver).where('created_at < ? AND created_at > ?', now , now-24.hours )
    mail to: "to@example.org", subject: "Realtime D3 messages | Daily Update"
  end
end
