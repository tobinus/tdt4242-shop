class Deal < ApplicationRecord
  belongs_to :product
  validates :type, inclusion: { in: %w(VolumeDeal PercentageDeal) }
  validates :product, presence: true
  validate :only_one_deal_of_each_type

=begin
  def deal_amount_larger_trigger_amount
    errors.add(:deal_amount, "must be larger than trigger amount") unless
      deal_type == 'percentage' or (deal_amount > trigger_amount)
  end
=end

  def only_one_deal_of_each_type
    logger.debug "Deal ID: #{id}"
    logger.debug Deal.where({ product_id: product_id, type: type }).count

    errors.add(:type, "– You have already created a #{type} for #{product.name}. Please remove the existing deal before creating a new one.") unless
        Deal.where({ product_id: product_id, type: type }).count.zero? or Deal.where({ product_id: product_id, type: type }).first.id == id
  end
end
