class AddAddressToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users,:address,:text
    remove_column :users,:password
  end
end
