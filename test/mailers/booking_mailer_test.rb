require 'test_helper'

class BookingMailerTest < ActionMailer::TestCase
  test "daily_email" do
    mail = BookingMailer.daily_email
    assert_equal "Daily email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
