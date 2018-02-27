class VolumeDeal < Deal
  validates :trigger_amount, presence: true, numericality: { :only_integer => true, minimum: 1 }
  validates :deal_amount, presence: true, numericality: { :only_integer => true, minimum: 2, greater_than: :trigger_amount }

  def deal_print
    deal = VolumeDeal.find(id)
    product = Product.find(deal.product_id)
    "Buy #{deal.trigger_amount}, get #{deal.deal_amount - deal.trigger_amount} free on #{product.name}"
  end

  def deal_print_short
    deal = VolumeDeal.find(id)
    "Buy #{deal.trigger_amount}, get #{deal.deal_amount - deal.trigger_amount} free"
  end

  # this will forward routes looking for volume_deal to deal
  def self.model_name
    Deal.model_name
  end
end