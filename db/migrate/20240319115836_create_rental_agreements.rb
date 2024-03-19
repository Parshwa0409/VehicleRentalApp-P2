class CreateRentalAgreements < ActiveRecord::Migration[7.1]
  def change
    create_table :rental_agreements do |t|
      t.date :start_date
      t.date :end_date
      t.integer :total_cost
      t.boolean :acitve, default: false
      t.belongs_to :user, foreign_key: true
      t.belongs_to :vehicle, foreign_key: true

      t.timestamps
    end
  end
end
