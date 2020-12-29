class AdminController < ApplicationController
  include ApplicationHelper
  before_action :userisadmin

  def show
    @products=Product.all
    @transaction_orders=TransactionOrder.all
    @best_sell=Product.left_joins(:order_products).select("products.id as product_final_id, *, sum(quantity) as totalsell").group('product_final_id').order('totalsell DESC')

  end

  def test

  end
end
