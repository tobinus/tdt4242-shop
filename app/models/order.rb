class Order < ApplicationRecord
  has_many :order_items
  accepts_nested_attributes_for :order_items
  belongs_to :user
  validates :total_amount, presence: true, numericality: { greater_than: 0 }
  # validate cc number as 8 to 19 digits (according to IIN standard)
  validates :credit_card_number, presence: true, length: { minimum: 8, maximum: 19 }, numericality: true
  validates :credit_card_name, presence: true, length: { minimum: 3 }
  validates :credit_card_type, presence: true
  validates :credit_card_cvc, presence: true, length: { is: 3 }, numericality: true
  validates :credit_card_expiry, presence: true
  validate :order_items_present

  private

  def order_items_present
    errors.add(:order_items, " – There must be at least one product in the order.") unless
        order_items.count >= 1
  end
end
