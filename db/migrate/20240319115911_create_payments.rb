class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.string :cardholder_name
      t.string :card_number
      t.string :cvv
      t.date :expiry_date

      t.timestamps
    end
  end
end
