class CreateOrderProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :order_products do |t|
      t.integer :product_id
      t.integer :transaction_order_id

      t.timestamps
    end
  end
end
