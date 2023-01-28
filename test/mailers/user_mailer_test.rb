require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "new_article_notification" do
    mail = UserMailer.new_article_notification
    assert_equal "New article notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
