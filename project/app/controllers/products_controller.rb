class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  before_action :userisadmin, only: [:new, :edit, :create, :update, :destroy, :remove_picture]


  def remove_picture
    @product = Product.find_by id: params[:product_id]
    if @product.nil?
      redirect_to admin_path
    else
      if @product.pics.size <= params[:pid].to_i
        redirect_to admin_path and return
      else
        @product.pics.delete_at params[:pid].to_i
        @product.save
        redirect_to edit_product_path @product
      end
    end
  end


  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    if @products.size > 8
      @newarrival = @products.slice(-1, -8)
    else
      @newarrival = @products
    end
    @feature_products = @products.slice(0, 3)
    @bestsell = @products.slice(0, 3)
    @discount = @products.slice(0, 3)
  end

  def inspect
    @products = Product.all
    @name = "全部商品"
    @count = @products.size
    @product_types = ProductType.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @cartitem = Cartitem.new
    @guess_likes=Product.all
  end

  # GET /products/new
  def new
    @product = Product.new
    @all_remain_types = ProductType.all
  end

  # GET /products/1/edit
  def edit
    @nowtype = @product.product_type_id
    @all_remain_types = ProductType.where ('not id=' + @nowtype.to_s)
    @now_type = @product.product_type
  end

  # POST /products
  # POST /products.json
  def create


    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to edit_product_path @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to edit_product_path @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html {redirect_to edit_product_path @product }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to admin_path , notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :price, :description, :detail, {pics: []}, :product_type_id,:color_id,:material, :size)
  end
end
