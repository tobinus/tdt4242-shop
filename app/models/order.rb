class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user

  def self.find_products_in_order(order_id)
    @order = Order.find(order_id)
    @order_items = OrderItem.where(order_id: @order.id)
    @products_in_order = Array.new

    @order_items.each do |order_item|
      @product_in_order = Product.find(order_item.product_id)
      @full_order_item =
        {
          product_id: order_item.product_id,
          name: @product_in_order.name,
          description: @product_in_order.description,
          price: @product_in_order.stock_level,
          amount: order_item.amount
        }
      @products_in_order.push(@full_order_item)
    end
    @products_in_order
  end
end
