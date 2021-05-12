class CartitemsController < ApplicationController
  include ApplicationHelper
  include CartitemsHelper
  before_action :set_cartitem, only: [:show, :edit, :update, :destroy]
  before_action :useriscustomer
  skip_before_action :verify_authenticity_token, only:[:create,:update]


  # GET /cartitems
  # GET /cartitems.json
  def index
    @cartitems = current_user.cartitems
  end

  # GET /cartitems/1
  # GET /cartitems/1.json
  def show
  end

  # GET /cartitems/new
  def new
    @cartitem = Cartitem.new
    @cartitem.user = current_user
  end

  # GET /cartitems/1/edit
  def edit
  end

  # POST /cartitems
  # POST /cartitems.json
  def create
    @cartitem = Cartitem.where user_id: current_user.id, product_id: params[:cartitem][:productid]
    @targetproduct = Product.find params[:cartitem][:productid]
    if @targetproduct.nil? || Integer(params[:cartitem][:quantity]) < 0
      redirect_to root_path
      return
    end
    if @cartitem.size==0
      @cartitem = Cartitem.new(cartitem_params)
      @cartitem.user = current_user
      @cartitem.product = Product.find params[:cartitem][:productid]
    else
      @cartitem=@cartitem[0]
      @cartitem.quantity = @cartitem.quantity+Integer(params[:cartitem][:quantity])
    end
    respond_to do |format|
      if @cartitem.save
        #format.html { redirect_to @targetproduct, notice: '成功添加到购物车' }
        format.json { render json:get_cart_info}
      else
        format.html { render @targetproduct }
        format.json { render json: @cartitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cartitems/1
  # PATCH/PUT /cartitems/1.json
  def update
    respond_to do |format|
      if @cartitem.update(cartitem_params)
        format.html { redirect_to cartitems_url, notice: 'Cartitem was successfully updated.' }
        format.json { render :show, status: :ok, location: @cartitem }
      else
        format.html { render :edit }
        format.json { render json: @cartitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cartitems/1
  # DELETE /cartitems/1.json
  def destroy
    @cartitem.destroy
    respond_to do |format|
      format.html { redirect_to cartitems_url, notice: 'Cartitem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cartitem
    @cartitem = Cartitem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def cartitem_params
    params.require(:cartitem).permit(:quantity)
  end
end
