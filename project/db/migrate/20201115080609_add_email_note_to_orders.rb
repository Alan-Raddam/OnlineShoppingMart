class AddEmailNoteToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :transaction_orders,:email,:text
    add_column :transaction_orders,:note,:text
  end
end
