require 'test_helper'

class MailHandlerTest < ActionMailer::TestCase
  test "receive" do
    mail = MailHandler.receive
    assert_equal "Receive", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
