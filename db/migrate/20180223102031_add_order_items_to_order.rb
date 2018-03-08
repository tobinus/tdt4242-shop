class AddOrderItemsToOrder < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :order_items
  end
end
