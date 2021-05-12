class AddPicsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :pics, :string
  end
end
