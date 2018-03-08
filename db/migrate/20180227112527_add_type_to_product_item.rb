class AddTypeToProductItem < ActiveRecord::Migration[5.1]
  def change
    add_column :product_items, :type, :string
  end
end
