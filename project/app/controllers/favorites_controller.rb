class FavoritesController < ApplicationController
  include ApplicationHelper
  before_action :useriscustomer, only: [:reverse, :index]
  skip_before_action :verify_authenticity_token, only: :reverse

  def reverse
    @all = Favorite.find_by(user_id: current_user.id, product_id: params[:product_id])
    if @all.nil? #应该添加这个关系
      @favorite = Favorite.new
      @favorite.user_id = current_user.id
      @favorite.product_id = params[:product_id]
      if @favorite.save
        render json: {status: 1}
      else
        render json: {status: -1}
      end
    else
      #应该删除喜欢关系
      Favorite.where(user_id: current_user.id, product_id: params[:product_id]).delete_all
      render json: {status: 0}
    end
  end

  def index
    @products = Product.find_by_sql("select * from products inner join favorites on favorites.product_id=products.id where favorites.user_id="+current_user.id.to_s)
    @products.each do |x|
      x.id=x.product_id
    end
    @name = "我的收藏"
    @count = @products.size
    @product_types = ProductType.all
  end


  # POST /favorites
  # POST /favorites.json

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_favorite
    @favorite = Favorite.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def favorite_params
    params.fetch(:favorite, {})
  end
end
