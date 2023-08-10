class CartsController < ApplicationController
  def show_cart
    @cart_items = cart_items
  end
  def add_to_cart
    product_id = params[:product_id].to_i
    cart_items[product_id] ||= 0
    cart_items[product_id] += 1
    puts "Cart after adding item: #{session[:cart]}"
    redirect_to show_cart_path
  end


  def update_quantity
    product_id = params[:product_id].to_i
    quantity = params[:quantity].to_i
    if quantity <= 0
      cart_items.delete(product_id)
    else
      cart_items[product_id] = quantity
    end
    redirect_to show_cart_path
  end

  def remove_from_cart
    product_id = params[:product_id].to_i
    cart_items.delete(product_id)
    redirect_to show_cart_path
  end

  def checkout
    @cart_items = cart_items
  # Call the method on the order instance
  end

  private

  def calculate_totals
    @order.total_price = 0
    @cart_items.each do |product_id, quantity|
      product = Product.find(product_id)
      @order.total_price += product.product_price * quantity
    end
  end


  private

  def cart_items
    session[:cart] ||= {}
    session[:cart]
  end

  def process_checkout
    @cart_items = cart_items
    @order = current_user.orders.build(order_params)
    @order.calculate_taxes

    if @order.save
      @cart_items.each do |product_id, quantity|
        # Deduct quantity from product inventory
        product = Product.find(product_id)
        product.update(inventory: product.inventory - quantity)
      end

      session[:cart] = {} # Clear the cart
      redirect_to order_confirmation_path(@order)
    else
      render :checkout
    end
  end

  private

  def order_params
    params.require(:order).permit(:address, :province)
  end
end
