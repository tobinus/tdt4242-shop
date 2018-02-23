class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product #TODO or has_one?
end
