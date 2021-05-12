class AddQuantityToOrderProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :order_products,:quantity,:integer,default: 1
  end
end
