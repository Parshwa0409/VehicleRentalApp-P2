class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      t.string :brand
      t.string :model
      t.integer :year
      t.integer :price_per_day
      t.string :brand_logo
      t.boolean :is_rented, default: false

      t.timestamps
    end
  end
end
