class RemoveAttributesFromOrderAndCartItems < ActiveRecord::Migration[5.1]
  def change
    remove_reference :order_items, :product
    remove_reference :order_items, :order
    remove_reference :cart_items, :product
    remove_reference :cart_items, :cart
    remove_column :order_items, :amount
    remove_column :cart_items, :amount
  end
end
