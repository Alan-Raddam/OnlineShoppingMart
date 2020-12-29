class CreateTransactionItems < ActiveRecord::Migration[6.0]
  def change
    create_table :transaction_items do |t|
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
