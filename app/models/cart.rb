class Cart < ApplicationRecord
  has_many :cart_items
  belongs_to :user

=begin
  def self.find_cart_items(cart_id)
    @cart_items = CartItem.where(cart_id: cart_id)
  end
=end

=begin
  def self.find_products_in_cart(cart_id)
    @cart = Cart.find(cart_id)
    @cart_items = CartItem.where(cart_id: @cart.id)
    @products_in_cart = Array.new

    @cart_items.each do |cart_item|
      @product_in_cart = Product.find(cart_item.product_id)
      @full_cart_item =
        {
          product_id: cart_item.product_id,
          name: @product_in_cart.name,
          description: @product_in_cart.description,
          price: @product_in_cart.stock_level,
          amount: cart_item.amount
        }
      @products_in_cart.push(@full_cart_item)
    end
    @products_in_cart
  end
=end

  def self.product_in_cart?(user_id, product_id)
    @cart = Cart.find_by(user_id: user_id)
    @cart.cart_items.each do |cart_item|
      if cart_item.product_id == product_id
        return true
      end
    end
    return false
  end

end
