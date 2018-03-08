class AddPaymentDetailsToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :credit_card_number, :string
    add_column :orders, :credit_card_expiry, :date
    add_column :orders, :credit_card_cvc, :string
    add_column :orders, :credit_card_name, :string
    add_column :orders, :credit_card_type, :string
  end
end
