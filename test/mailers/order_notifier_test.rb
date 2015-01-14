require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    item = LineItem.new
    test_cart = item.build_cart
    item.product = products(:ruby)
    item.save!
    test_order = orders(:one)
    test_order.add_line_items_from_cart(test_cart)
    mail = OrderNotifier.received(test_order)
    assert_equal "编程书店订单确认", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["read2000@sina.cn"], mail.from
    assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
  end

  test "shipped" do
    item = LineItem.new
    test_cart = item.build_cart
    item.product = products(:ruby)
    item.save!
    test_order = orders(:one)
    test_order.add_line_items_from_cart(test_cart)
    mail = OrderNotifier.shipped(test_order)
    assert_equal "编程书店发货提醒", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["read2000@sina.cn"], mail.from
    assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
  end

end
