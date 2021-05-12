class CreateTransactionOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :transaction_orders do |t|
      t.decimal :sum
      t.text :address
      t.text :name
      t.text :phone
      t.text :postcode
      t.text :sstatus

      t.timestamps
    end
  end
end
