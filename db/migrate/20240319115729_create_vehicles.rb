class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      t.string :brand
      t.string :model
      t.integer :year
      t.integer :price_per_day
      t.string :photo
      t.boolean :is_rented

      t.timestamps
    end
  end
end
