class AddProductAttributes < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :name, :string
    add_column :products, :stock_level, :integer
    add_column :products, :price, :float
    add_column :products, :brand, :string
    add_column :products, :material, :string
    add_column :products, :weight, :float
  end
end
