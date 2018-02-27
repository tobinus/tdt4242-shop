class AddAttributesToDeals < ActiveRecord::Migration[5.1]
  def change
    add_column :deals, :type, :string
  end
end
