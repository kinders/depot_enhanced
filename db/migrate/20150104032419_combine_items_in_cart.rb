class CombineItemsInCart < ActiveRecord::Migration
  def up
    # 将每个商品的多个item进行合并
    Cart.all.each do |cart|
      # 对购物车内每样产品进行计数
      sums = cart.line_items.group(:product_id).sum(:quantity)
      sums.each do |product_id, quantity|
        if quantity > 1
          # 移除item
          cart.line_items.where(product_id: product_id).delete_all
          # 用单个item替代
          item = cart.line_items.build(product_id: product_id)
          item.quantity = quantity
          item.save!
        end
      end
    end
  end

  def down
    # 将数量多于1的line_item分割为多行
    LineItem.where("quantity>1").each do |line_item|
      # 逐个增加每个line_item
      line_item.quantity.times do
        LineItem.create cart_id: line_item.cart_id, 
	                         product_id: line_item.product_id, quantity: 1
        #<kinder:note> 这两句（其实是一句）挺有意思，`cart_id`和`procut_id`、`quantity`都是create的参数。
      end
      # 移除原来的line_item
      line_item.destroy
    end
  end

end
