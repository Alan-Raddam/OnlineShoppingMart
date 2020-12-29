class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.text :name
      t.decimal :price
      t.integer :favorites
      t.integer :sales
      t.text :description
      t.text :image_directory
      t.integer :gender

      t.timestamps
    end
  end
end
