class CreateVolumeDeals < ActiveRecord::Migration[5.1]
  def change
    create_table :volume_deals do |t|

      t.timestamps
    end
  end
end
