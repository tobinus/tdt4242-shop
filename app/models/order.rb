class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user
  # validate cc number as 8 to 19 digits (according to IIN standard)
  validates :credit_card_number, presence: true, length: { minimum: 8, maximum: 19 }, numericality: true
  validates :credit_card_name, presence: true, length: { minimum: 3 }
  validates :credit_card_type, presence: true
  validates :credit_card_cvc, presence: true, length: { is: 3 }, numericality: true
  validates :credit_card_expiry, presence: true
end
