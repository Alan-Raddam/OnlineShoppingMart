class AddRefToTransactionOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :transaction_orders,:user,foreign_key:true
  end
end
