class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product #TODO or has_one?
end
