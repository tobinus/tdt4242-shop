class RemoveOrderItemsFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_reference :orders, :order_items
  end
end
