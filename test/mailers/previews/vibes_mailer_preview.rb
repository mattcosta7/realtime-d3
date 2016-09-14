# Preview all emails at http://localhost:3000/rails/mailers/messages_mailer
class MessagesMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/messages_mailer/message_received
  def message_received
    @message = Message.first
    MessagesMailer.message_received(@message)
  end

  # Preview this email at http://localhost:3000/rails/mailers/messages_mailer/daily_update
  def daily_update
    MessagesMailer.daily_update
  end

end
