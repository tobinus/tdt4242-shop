class CreatePercentageDeals < ActiveRecord::Migration[5.1]
  def change
    create_table :percentage_deals do |t|

      t.timestamps
    end
  end
end
