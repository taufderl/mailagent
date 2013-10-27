require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "notify_new_admin" do
    mail = UserMailer.notify_new_admin
    assert_equal "Notify new admin", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
