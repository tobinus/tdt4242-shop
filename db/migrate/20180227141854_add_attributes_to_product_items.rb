class AddAttributesToProductItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :product_items, :cart, foreign_key: true
    add_reference :product_items, :order, foreign_key: true
    add_reference :product_items, :product, foreign_key: true
    add_column :product_items, :amount, :integer
  end
end
