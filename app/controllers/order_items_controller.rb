class OrderItemsController < ApplicationController
  def new
    @order_item = OrderItem.new
  end

  def create
    @order_item = OrderItem.new(order_item_params)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:order_id, :product_id, :amount)
  end
end