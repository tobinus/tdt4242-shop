class AddAttributesToDeal < ActiveRecord::Migration[5.1]
  def change
    add_reference :deals, :product, foreign_key: true
    add_column :deals, :deal_type, :integer
    add_column :deals, :trigger_amount, :integer
    add_column :deals, :deal_amount, :integer
    add_column :deals, :discount_percentage, :float
  end
end
