class AdminController < ApplicationController
  before_action :authorize_administrator
  def index
    @total_orders = Order.all.count
    @unship_orders = Order.where("is_ship = 'f'").count
    #@not_ship_products = []
    @not_ship_orders = []
    Order.where(is_ship: :f).each do |order|
      @not_ship_orders << [order.id, order.created_at]
    end
  end
end
