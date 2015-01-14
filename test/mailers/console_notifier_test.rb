require 'test_helper'

class ConsoleNotifierTest < ActionMailer::TestCase
  test "error_occured" do
    e = '这是一个错误'
    mail = ConsoleNotifier.error_occured(e)
    assert_equal "Depot App出现了错误", mail.subject
    assert_equal ["869027168@qq.com"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match e, mail.body.encoded
  end

end
