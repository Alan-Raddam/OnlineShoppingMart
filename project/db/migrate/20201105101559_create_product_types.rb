class CreateProductTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :product_types do |t|
      t.text :product_type_name

      t.timestamps
    end
  end
end
