class CreateFixedDeposits < ActiveRecord::Migration
  def change
    create_table :fixed_deposits do |t|
      t.string :account_number
      t.integer :customer_id
      t.date :opening_date
      t.timestamps
    end
  end
end
