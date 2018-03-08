class AddUsersToCart < ActiveRecord::Migration[5.1]
  def change
    add_reference :carts, :user, foreign_key: true
    add_reference :carts, :cart_item, foreign_key: true
  end
end
