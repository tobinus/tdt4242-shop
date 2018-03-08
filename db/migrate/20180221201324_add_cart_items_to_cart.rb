class AddCartItemsToCart < ActiveRecord::Migration[5.1]
  def change
    remove_reference :carts, :cart_item, foreign_key: true
    add_reference :carts, :cart_items, foreign_key: true
  end
end
