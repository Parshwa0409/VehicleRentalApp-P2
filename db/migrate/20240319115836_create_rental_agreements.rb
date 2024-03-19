class CreateRentalAgreements < ActiveRecord::Migration[7.1]
  def change
    create_table :rental_agreements do |t|
      t.date :start_date
      t.date :end_date
      t.integer :total_cost
      t.boolean :acitve

      t.timestamps
    end
  end
end
