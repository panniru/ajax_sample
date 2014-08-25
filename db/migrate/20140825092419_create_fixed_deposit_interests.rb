class CreateFixedDepositInterests < ActiveRecord::Migration
  def change
    create_table :fixed_deposit_interests do |t|
      t.date :interest_date
      t.float :interest_percentage

      t.timestamps
    end
  end
end
