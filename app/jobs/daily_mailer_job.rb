class DailyMailerJob
  include Sidekiq::Worker

  def perform
    MessagesMailer.delay.daily_update
  end
end
