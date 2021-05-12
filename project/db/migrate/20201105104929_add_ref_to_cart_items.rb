class AddRefToCartItems < ActiveRecord::Migration[6.0]

  def change
    add_reference :cartitems,:user,foreign_key:true
    add_reference :cartitems,:product,foreign_key:true
  end

end
