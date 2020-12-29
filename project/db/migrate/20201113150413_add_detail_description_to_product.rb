class AddDetailDescriptionToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :detail, :text
  end
end
