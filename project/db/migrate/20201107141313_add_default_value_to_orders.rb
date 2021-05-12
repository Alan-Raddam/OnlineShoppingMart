class AddDefaultValueToOrders < ActiveRecord::Migration[6.0]
  def change
    change_column :transaction_orders,:sstatus,:integer,default: 0
  end
end
