class PercentageDeal < Deal
  validates :discount_percentage, presence: true, numericality: { minimum: 0, maximum: 100 }

  def deal_print
    deal = PercentageDeal.find(id)
    product = Product.find(deal.product_id)
    "#{(deal.discount_percentage * 100).round(0)}% off #{product.name}"
  end

  def deal_print_short
    deal = PercentageDeal.find(id)
    "#{(deal.discount_percentage * 100).round(0)}% off"
  end

  # this will forward routes looking for percentage_deal to deal
  def self.model_name
    Deal.model_name
  end
end