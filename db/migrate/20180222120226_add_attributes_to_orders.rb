class AddAttributesToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :order_items, :order, foreign_key: true
    add_reference :order_items, :product, foreign_key: true
    add_column :order_items, :amount, :integer
    add_reference :orders, :user, foreign_key: true
  end
end
