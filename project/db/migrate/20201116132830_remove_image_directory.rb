class RemoveImageDirectory < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :image_directory
  end
end
