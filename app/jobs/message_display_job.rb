class MessageDisplayJob
  include Sidekiq::Worker

  def perform(message_id)
    message = Message.find(message_id)
    ActionCable.server.broadcast 'messages_channel',
      id: message.id,
      label: message.body,
      sender: {
        id: message.sender.id,
        email: message.sender.email
      },
      receiver: {
        id: message.receiver.id,
        email: message.receiver.email
      }
  end
end
