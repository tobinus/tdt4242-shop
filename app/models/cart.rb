class Cart < ApplicationRecord
  has_many :cart_items
  belongs_to :user

  def self.product_in_cart?(user_id, product_id)
    @cart = Cart.find_by(user_id: user_id)
    # check if any of the cart_items correspond to the given product and return result
    @cart.cart_items.where(product_id: product_id).length > 0
  end

end
