require 'test_helper'

class ListMailerTest < ActionMailer::TestCase
  test "send_to_list" do
    mail = ListMailer.send_to_list
    assert_equal "Send to list", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
