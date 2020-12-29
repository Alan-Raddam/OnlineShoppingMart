class AddRefToTransactionItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :transaction_items,:user,foreign_key:true
    add_reference :transaction_items,:product,foreign_key:true
    add_reference :transaction_items,:transaction_order,foreign_key:true
  end
end
