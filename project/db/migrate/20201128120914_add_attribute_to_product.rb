class AddAttributeToProduct < ActiveRecord::Migration[6.0]
  def change
    remove_column :products,:size_id
    remove_column :products,:gender
    remove_column :products,:sales
    remove_column :products,:favorites
    add_column :products,:size,:text
    add_column :products,:material, :text
  end
end
