module CartitemsHelper
  def get_cart_info
    @result=Array.new
    @all=current_user.cartitems
    @all.each do |x|
      if x.product.pics.size!=0
        @result<<{
            name: x.product.name,
            quantity: x.quantity,
            product_id: x.product_id,
            total_price: x.quantity*x.product.price,
            price: x.product.price,
            image_directory:x.product.pics[0]
        }
      else
        @result<<{
            name: x.product.name,
            quantity: x.quantity,
            product_id: x.product_id,
            total_price: x.quantity*x.product.price,
            price: x.product.price,
        }
      end
    end
    @result
  end

end
