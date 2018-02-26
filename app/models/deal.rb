class Deal < ApplicationRecord
  enum deal_type: [:volume, :percentage]
  belongs_to :product
  validates :deal_type, inclusion: { in: %w(volume percentage) }
  validates :product, presence: true
  validate :volume_fields
  validate :percentage_field
  validate :deal_amount_larger_trigger_amount
  validate :only_one_deal_of_each_type

  def deal_print
    deal = Deal.find(id)
    product = Product.find(deal.product_id)
    if deal.deal_type == 'percentage'
      "#{(deal.discount_percentage * 100).round(0)}% off #{product.name}"
    else
      "Buy #{deal.trigger_amount}, get #{deal.deal_amount - deal.trigger_amount} free on #{product.name}"
    end
  end

  def deal_print_short
    deal = Deal.find(id)
    product = Product.find(deal.product_id)
    if deal.deal_type == 'percentage'
      "#{(deal.discount_percentage * 100).round(0)}% off"
    else
      "Buy #{deal.trigger_amount}, get #{deal.deal_amount - deal.trigger_amount} free"
    end
  end

  def deal_amount_larger_trigger_amount
    errors.add(:deal_amount, "must be larger than trigger amount") unless
      deal_type == 'percentage' or (deal_amount > trigger_amount)
  end

  def only_one_deal_of_each_type
    logger.debug product_id
    logger.debug deal_type
    logger.debug Deal.where({ product_id: product_id, deal_type: deal_type }).count
    errors.add(:deal_type, "– You have already created a #{deal_type}-based deal for #{product.name}. Please remove the existing deal before creating a new one.") unless
        Deal.where({ product_id: product_id, deal_type: deal_type }).count.zero?
  end

  def volume_fields
    errors.add(:trigger_amount, "must be filled out") unless trigger_amount.present?
    errors.add(:deal_amount, "must be filled out") unless deal_amount.present?
  end

  def percentage_field
    errors.add(:discount_percentage, "must be filled out") unless discount_percentage.present?
  end
end
