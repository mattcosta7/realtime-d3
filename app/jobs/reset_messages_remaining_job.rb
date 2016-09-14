class ResetMessagesRemainingJob
  include Sidekiq::Worker

  def perform
    User.all.each do |user|
      user.update(messages_remaining: User::INITIAL_MESSAGE_AMOUNT)
    end
  end
end
