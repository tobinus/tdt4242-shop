class CreateProductItems < ActiveRecord::Migration[5.1]
  def change
    create_table :product_items do |t|

      t.timestamps
    end
  end
end
