require 'test_helper'

class MessagesMailerTest < ActionMailer::TestCase
  test "message_received" do
    mail = MessagesMailer.message_received
    assert_equal "Message received", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "daily_update" do
    mail = MessagesMailer.daily_update
    assert_equal "Daily update", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
