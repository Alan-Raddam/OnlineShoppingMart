class TransactionOrdersController < ApplicationController
  include ApplicationHelper
  before_action :set_transaction_order, only: [:show, :edit, :update, :destroy, :adminedit,:receive_product]
  before_action :useriscustomer, only: [:new,:edit,:create,:receive_product]
  before_action :userisadmin, only: [:index, :adminedit]
  before_action :usersignedin,only: [:update,:destroy]
  skip_before_action :verify_authenticity_token, only: [:create]

  # GET /transaction_orders
  # GET /transaction_orders.json
  def index
    @transaction_orders = TransactionOrder.all
  end

  def setpaid
    @transaction_order=TransactionOrder.find(params[:id])
    if @transaction_order.sstatus==0
      @transaction_order.sstatus=1
      @transaction_order.save
    end
    redirect_to @transaction_order
  end


  # GET /transaction_orders/1
  # GET /transaction_orders/1.json
  def show
  end

  # GET /transaction_orders/new
  def new
    @transaction_order = TransactionOrder.new
    @transaction_order.user = current_user
    @transaction_order.sum = 0
    @targetproducts = Array.new
    current_user.cartitems.each do |x|
      @targetproducts << x.product
      @transaction_order.sum += x.product.price * x.quantity
    end
    if @targetproducts.size == 0
      redirect_to root_path, notice: "购物车为空，接着逛逛吧"
    end

    #targetproducts用于预览客户即将要结账的所有商品


  end

  # GET /transaction_orders/1/edit
  def edit
    unless @transaction_order.sstatus == 0
      redirect_to @transaction_order, notice: "该订单不能修改"
    end
  end

  def adminedit
    @bought = Product.left_joins(:order_products).select("products.id as product_final_id, *").where('transaction_order_id=' + @transaction_order.id.to_s)

  end

  # POST /transaction_orders
  # POST /transaction_orders.json
  def create
    @transaction_order = TransactionOrder.new(transaction_order_params) #name,address,phone,postcode
    @transaction_order.user = current_user #用户
    @transaction_order.sum = 0
    @targetproducts = Array.new
    current_user.cartitems.each do |x|
      @targetproducts << x
      @transaction_order.sum += x.product.price * x.quantity
    end
    #并且计算总额
    respond_to do |format|
      if @transaction_order.save
        #清空当前用户的购物车
        @targetproducts.each do |x|
          #为订单和产品之间添加关系
          @newrelation = OrderProduct.new
          @newrelation.transaction_order = @transaction_order
          @newrelation.product = x.product
          @newrelation.quantity = x.quantity
          @newrelation.save
        end
        Cartitem.where('user_id=' + current_user.id.to_s).delete_all
        format.html { redirect_to @transaction_order, notice: '订单创建成功' }
        format.json { render :show, status: :created, location: @transaction_order }
      else
        format.html { render :new }
        format.json { render json: @transaction_order.errors, status: :unprocessable_entity }
      end
    end
  end

  def receive_product
    if current_user!=@transaction_order.user
      redirect_to root_path, notice: "非法操作"
      return
    end
    if @transaction_order.sstatus!=2
      redirect_to root_path, notice: "非法操作"
      return
    end
    @transaction_order.sstatus=4
    respond_to do |format|
      if @transaction_order.save
        format.html { redirect_to @transaction_order, notice: 'Transaction order was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction_order }
      else
        format.html { render :edit }
        format.json { render json: @transaction_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transaction_orders/1
  # PATCH/PUT /transaction_orders/1.json
  def update
    if @transaction_order.user != current_user && !current_user.isadmin?
      redirect_to root_path, notice: "非法操作"
      return
    end
    if @transaction_order.sstatus != 0 && !current_user.isadmin?
      redirect_to root_path, notice: "非法操作"
      return
    end
    if !current_user.isadmin?
      respond_to do |format|
        if @transaction_order.update(transaction_order_params)
          format.html { redirect_to @transaction_order, notice: 'Transaction order was successfully updated.' }
          format.json { render :show, status: :ok, location: @transaction_order }
        else
          format.html { render :edit }
          format.json { render json: @transaction_order.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        if @transaction_order.update(transaction_order_params)
          format.html { redirect_to transaction_orders_path, notice: 'Transaction order was successfully updated.' }
          format.json { render :show, status: :ok, location: @transaction_order }
        else
          format.html { render :edit }
          format.json { render json: @transaction_order.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /transaction_orders/1
  # DELETE /transaction_orders/1.json
  def destroy
    unless @transaction_order.user == current_user
      redirect_to root_path, notice: "非法操作"
      return
    end
    if @transaction_order.sstatus != 0
      redirect_to @transaction_order, notice: "该订单不能取消"
    end
    @transaction_order.sstatus = 3
    @transaction_order.save
    respond_to do |format|
      format.html { redirect_to @transaction_order, notice: "订单已经成功取消" }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction_order
    @transaction_order = TransactionOrder.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_order_params
    if !current_user.nil? and current_user.isadmin? #管理员允许更改的参数！
      params.require(:transaction_order).permit(:address, :name, :phone, :postcode, :email, :note, :sstatus)
    else
      if !current_user.nil? and !current_user.isadmin?
        params.require(:transaction_order).permit(:address, :name, :phone, :postcode, :email, :note)
      end
    end
  end
end
